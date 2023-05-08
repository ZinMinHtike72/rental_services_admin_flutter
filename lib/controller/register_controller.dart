import 'package:flutter/material.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/home/main_screen.dart';
class Register_Controller{
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _status = false;
  bool _isHide = true;
  Map<String,String> validateError = {
    "email" : "",
    "password":"",
    "name":"",
    "confirmPassword":""
  };

  TextEditingController getNameController(){
    return _nameController;
  }

  TextEditingController getEmailController(){
    return _emailController;
  }

  TextEditingController getPasswordController(){
    return _passwordController;
  }

  TextEditingController getConfirmPassController(){
    return _confirmPasswordController;
  }

  GlobalKey<FormState> getFormKey(){
    return _formKey;
  }



  void register({required BuildContext context}) async{
    // debugPrint(Constant_Api.registerApi);
    bool checkIsHaveEmail = Reuseable_Function.checkIsHave(value: _emailController.text);
    bool checkIsHavePassword = Reuseable_Function.checkIsHave(value: _passwordController.text);
    bool checkIsHaveName =  Reuseable_Function.checkIsHave(value: _nameController.text);
    bool checkIsHaveConfirmPass = Reuseable_Function.checkIsHave(value: _confirmPasswordController.text);
    if(!checkIsHavePassword || !checkIsHaveEmail || !checkIsHaveConfirmPass ||!checkIsHaveConfirmPass){
      Map errorData = {
        "email" : checkIsHaveEmail ? "" : "Need To Fill The Email ! ",
        "password":checkIsHavePassword ? "" : "Need To Fill The Password",
        "name":checkIsHaveName ? "" : "Need To Fill The Name !",
        "confirmPassword":checkIsHaveConfirmPass ? '' : 'Need To Fill The Confirm Password !'
      };
      context.read<Login_Provider>().setRegisterError(data: errorData);
    }else{
      bool checkIsEmail = Reuseable_Function.checkIsEmail(value: _emailController.text);
      if(!checkIsEmail || _passwordController.text.length < 8){
        Map errorData = {
            "email" : checkIsEmail ? "" : "Your Email Is Invalid !",
            "password": _passwordController.text.length > 8 ? "" : "Password Must Be At Least 8 Characters !",
            "name":"",
        };
        context.read<Login_Provider>().setRegisterError(data: errorData);
      }else{
        Map errorData = {
          "email" : "",
        };
        context.read<Login_Provider>().setRegisterError(data: errorData);
        if(_passwordController.text != _confirmPasswordController.text){
          Map errorData = {
            "password" :  _passwordController.text == _confirmPasswordController.text? "" : "Password & Confirm Password Not Match !",
          };
          context.read<Login_Provider>().setRegisterError(data: errorData);
        }else{
          Map errorData = {
            "password" :  "",
          };
          context.read<Login_Provider>().setRegisterError(data: errorData);
          context.read<Login_Provider>().setRegisterStatus(data: true);
          final Map sendData = {
            "name":_nameController.text,
            "email":_emailController.text,
            "password":_passwordController.text
          };
          final Map data = await Api_Services.postMethod(data: sendData, path: Constant_Api.registerApi);
          context.read<Login_Provider>().setRegisterStatus(data: false);
          if(!data['error']){
            Storage_Services.setLoginData(data: data['data']);
            context.read<Login_Provider>().setLoginData(data: data['data']);
            Api_Services.setLoginData(data['data']);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Main_Screen()));
            Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Register Success !", status: 'success');
          }else{
            if(data['too_many'] != null){
              Alert_Dialog.Cus_Snackbar(context: context, label: data['message'],bgColor: Colors.red);
            }else{
              Alert_Dialog.Cus_Snackbar(context: context, label: data['data']['email'][0],bgColor: Colors.red);
            }

          }
        }
      }
    }
  }
}