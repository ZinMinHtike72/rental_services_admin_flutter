import 'package:flutter/material.dart';
import 'package:rental_services/components/cus_input.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/controller/profile_manage_controller.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/login_provider.dart';

class Change_Password extends StatefulWidget {
  Function changeTab;
  Change_Password({Key? key,required Function this.changeTab}) : super(key: key);

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  var passwordController = Profile_Manage_Controller();
  // String oldPassword = "";
  // String newPassword = '';
  // String confirmPassword = "";
  // bool status = false;
  // String? oldPasswordError;
  // String? newPasswordError;
  // String? confirmPasswordError;
  @override
  Widget build(BuildContext context) {
    // void changePassword() async{
    //   bool oldResult = Reuseable_Function.checkIsHave(value: oldPassword);
    //   bool newResult = Reuseable_Function.checkIsHave(value: newPassword);
    //   bool confirmResult = Reuseable_Function.checkIsHave(value: confirmPassword);
    //
    //   if(!oldResult || !newResult || !confirmResult){
    //     setState(() {
    //       oldPasswordError = !oldResult ? "Need To Fill The Old Password !" : null;
    //       newPasswordError = !newResult ? "Need To Fill The New Password !" : null;
    //       confirmPasswordError = !confirmResult ? "Need To Fill The Confirm Password !" : null;
    //     });
    //   }else{
    //     setState(() {
    //       oldPasswordError = null;
    //       newPasswordError = null;
    //       confirmPasswordError = null;
    //     });
    //     if(newPassword.length < 8){
    //      setState(() {
    //        newPasswordError = "New Password Must Be At Least 8 Characters!";
    //      });
    //     }else{
    //       if(newPassword != confirmPassword){
    //         setState(() {
    //           newPasswordError = "Password and Confirm Password Are Not Same!";
    //         });
    //       }else{
    //         setState(() {
    //           newPasswordError = null;
    //         });
    //         final Map sendData = {
    //           'old_password': oldPassword,
    //           'new_password' :newPassword,
    //           'new_password_confirmation' : confirmPassword
    //         };
    //         setState(() {
    //           status = true;
    //         });
    //        final resData = await Api_Services.postMethod(data: sendData, path:Constant_Api.changePassword );
    //        setState(() {
    //          status = false;
    //        });
    //       if(resData['error']){
    //         Alert_Dialog.Cus_Snackbar(context: context, label: resData['message'],bgColor: Colors.red);
    //       }else{
    //         widget.changeTab();
    //         Alert_Dialog.Cus_Alert_Dialog(context: context, title:"Change Password Success" , status: 'success');
    //         setState(() {
    //           print("pas");
    //           oldPassword = "";
    //           newPassword = "";
    //           confirmPassword = "";
    //         });
    //       }
    //       }
    //     }
    //
    //   }
    //
    // }
    return Consumer<Login_Provider>(
        builder: (context,data,child){
          return Container(
            padding: EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Cus_Input(label: "Old Password", onChange: (value){
                  passwordController.setOldPassword(value);
                },errorText:data.passwordError['oldPasswordError'] ,obscureText: true,value: passwordController.oldPassword,),
                SizedBox(
                  height: 7,
                ),
                Cus_Input(label: "New Password", onChange: (value){
                  passwordController.setNewPassword(value);
                },errorText: data.passwordError['newPasswordError'],obscureText: true,value: passwordController.newPassword,),
                SizedBox(
                  height: 7,
                ),
                Cus_Input(label: "Confirm New Password", onChange: (value){
                  setState(() {
                   passwordController.setConfirmPassword(value);
                  });
                },errorText: data.passwordError['confirmPasswordError'],obscureText: true,value: passwordController.confirmPassword,),
                SizedBox(
                  height: 20,
                ),
                Loading_Button(label: "Change Password", status: data.changePassStatus, loadingStatus: "Updating", onPressed:(){passwordController.changePassword(context: context, changeTab: widget.changeTab);})
              ],
            ),
          );
        }
    );
  }
}
