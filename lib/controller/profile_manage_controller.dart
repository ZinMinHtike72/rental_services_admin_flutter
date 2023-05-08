import 'package:flutter/material.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/screens/Authentication/login_screen.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class Profile_Manage_Controller{
  bool status =  false;
  String? profile;
  String name = '';

  //Password
  String oldPassword = "";
  String newPassword = '';
  String confirmPassword = "";

  void setName(String data){
    name = data;
  }

  void setProfile(String? data){
    profile = data;
  }

  void setOldPassword(String data){
    oldPassword = data;
  }

  void setNewPassword(String data){
    newPassword = data;
  }

  void setConfirmPassword(String data){
    confirmPassword = data;
  }



  //Logout
  Future<void> logOut ({required BuildContext context}) async{
    final resData = await Api_Services.postMethod(data: {}, path: Constant_Api.logoutApi);
    // if(!resData['error']){
      PersistentNavBarNavigator.pushAndRemoveUntil(context, screen: Login_Screen(),withNavBar: false);
      Navigator.of(context).pop();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login_Screen()));
      Storage_Services.deleteLoginData();
      context.read<Login_Provider>().logOut();
      Api_Services.setLoginData(null);
      Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Logout Success !", status: 'success');
    // }
  }

  //Logout Dialog
  void showDialog ({required BuildContext context}) {
    Alert_Dialog.Confirm_Dialog(context: context,title: "Are You Sure To Logout ?",actionText:"Logout",actionFun:(){return logOut(context: context);},buttonColor: Colors.red ,status: "logout");
  }

  //UPDATE PROFILE
  void updateProfile({required BuildContext context}) async{
    bool nameResult = Reuseable_Function.checkIsHave(value: name);
    if(!nameResult){
      context.read<Login_Provider>().setProfileUpdateNameError(data:  'Need To Fill The Name !');
    }else{
      context.read<Login_Provider>().setProfileUpdateNameError(data: null);
      final Map sendData = {
        "name":name,
        'profile':profile
      };
      context.read<Login_Provider>().setProfileUpdateStatus(data: true);
      final resData = await Api_Services.postMethod(data: sendData, path: Constant_Api.profile);
      context.read<Login_Provider>().setProfileUpdateStatus(data: false);
      if(!resData['error']){
        Storage_Services.setLoginData(data: resData['data']);
        context.read<Login_Provider>().setLoginData(data: resData['data']);
        Api_Services.setLoginData(resData['data']);
        Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Update Success !", status: 'success');
      }
    }
  }

  //PasswordChange
  void changePassword({required BuildContext context,required Function changeTab}) async{
    bool oldResult = Reuseable_Function.checkIsHave(value: oldPassword);
    bool newResult = Reuseable_Function.checkIsHave(value: newPassword);
    bool confirmResult = Reuseable_Function.checkIsHave(value: confirmPassword);

    if(!oldResult || !newResult || !confirmResult){
      Map errorData = {
          'oldPasswordError' : !oldResult ? "Need To Fill The Old Password !" : null,
          'newPasswordError' : !newResult ? "Need To Fill The New Password !" : null,
          'confirmPasswordError' :!confirmResult ? "Need To Fill The Confirm Password !" : null
     };
     context.read<Login_Provider>().setPasswordError(data: errorData);
    }else{
      Map errorData = {
        'oldPasswordError' : null,
        'newPasswordError' :null,
        'confirmPasswordError' : null
      };
      context.read<Login_Provider>().setPasswordError(data: errorData);
      if(newPassword.length < 8){
        Map errorData = {
          'newPasswordError' : "New Password Must Be At Least 8 Characters!",
        };
        context.read<Login_Provider>().setPasswordError(data: errorData);
      }else{
        if(newPassword != confirmPassword){
          Map errorData = {
            'newPasswordError' : "Password and Confirm Password Are Not Same!",
          };
          context.read<Login_Provider>().setPasswordError(data: errorData);
        }else{
          Map errorData = {
            'newPasswordError' : null,
          };
          context.read<Login_Provider>().setPasswordError(data: errorData);
          final Map sendData = {
            'old_password': oldPassword,
            'new_password' :newPassword,
            'new_password_confirmation' : confirmPassword
          };
          context.read<Login_Provider>().setChangePassStatus(data: true);
          final resData = await Api_Services.postMethod(data: sendData, path:Constant_Api.changePassword );
          context.read<Login_Provider>().setChangePassStatus(data: false);
          if(resData['error']){
            Alert_Dialog.Cus_Snackbar(context: context, label: resData['message'],bgColor: Colors.red);
          }else{
            changeTab();
            Alert_Dialog.Cus_Alert_Dialog(context: context, title:"Change Password Success" , status: 'success');
              oldPassword = "";
              newPassword = "";
              confirmPassword = "";
          }
        }
      }

    }

  }
}