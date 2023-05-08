import 'package:flutter/material.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/screens/home/main_screen.dart';

class Login_Controller{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _status= false;
  Map<String,String> validateError = {
    "email" : "",
    "password":"",
  };

  TextEditingController getEmailController(){
    return _emailController;
  }

  TextEditingController getPasswordController(){
    return _passwordController;
  }

  GlobalKey<FormState> getFormKey(){
    return _formKey;
  }

  void login({required BuildContext context}) async{
    bool checkIsHaveEmail = Reuseable_Function.checkIsHave(value: _emailController.text);
    bool checkIsHavePassword = Reuseable_Function.checkIsHave(value: _passwordController.text);
    if(!checkIsHavePassword || !checkIsHaveEmail){
      Map errorData = {
      "email" : checkIsHaveEmail ? "" : "Need To Fill The Email !",
      "password":checkIsHavePassword ? "" : "Need To Fill The Password",
      };
      context.read<Login_Provider>().setLoginError(data: errorData);
    }else{
      bool checkIsEmail = Reuseable_Function.checkIsEmail(value: _emailController.text);
      Map errorData = {
        "email" : checkIsEmail ? "" : "Your Email IS Invalid !",
        "password": "",
      };
     context.read<Login_Provider>().setLoginError(data: errorData);
      if(checkIsEmail){
        final sendData = {
          'email':_emailController.text,
          'password':_passwordController.text
        };
        context.read<Login_Provider>().setLoginStatus(data: true);
        final resData= await Api_Services.postMethod(data:sendData, path: Constant_Api.loginApi);
        context.read<Login_Provider>().setLoginStatus(data: false);
        if(!resData['error']){
          print("${resData["data"]}");
          Storage_Services.setLoginData(data: resData['data']);
          context.read<Login_Provider>().setLoginData(data: resData['data']);
          Api_Services.setLoginData(resData['data']);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Main_Screen()));
          Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Login Success !", status: 'success');
        }else{
          Alert_Dialog.Cus_Snackbar(context: context, label: resData['message'],bgColor: Colors.red);
        }
      }
    }
  }
}