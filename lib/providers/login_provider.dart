import 'package:flutter/foundation.dart';

class Login_Provider with ChangeNotifier{
  Map? loginData = null;
  bool isLogin = false;
  bool loginStatus = false;
  bool loginPassIsHide = true;
  bool registerStatus = false;
  bool registerPassIsHide = true;
  bool profileUpdateStatus = false;
  bool changePassStatus = false;
  String? profileUpdateNameError;

  Map passwordError = {
    'oldPasswordError' : null,
    'newPasswordError' :null,
    'confirmPasswordError' : null
  };
  Map loginError = {
    "email" : "",
    "password":"",
  };
  Map registerError = {
    "email" : "",
    "password":"",
    "name":"",
    "confirmPassword":""
  };

  void  setLoginData({required Map data}){
    loginData = data;
    isLogin = true;
    notifyListeners();
  }

  void logOut(){
    loginData = null;
    isLogin = false;
    notifyListeners();
  }

  //Set Login Error And Login Status From Login Screen
  void setLoginError({required Map data}){
    loginError = data;
    notifyListeners();
  }

  void setLoginStatus({required bool data}){
    loginStatus = data;
    notifyListeners();
  }

  void setLoginPassIsHide({required bool data}){
    loginPassIsHide = data;
    notifyListeners();
  }

  //Set Register Error And Register Status From Register Screen
  void setRegisterError({required Map data}){
    registerError = data;
    notifyListeners();
  }

  void setRegisterStatus({required bool data}){
    registerStatus = data;
    notifyListeners();
  }

  void setRegisterPassIsHide({required bool data}){
    registerPassIsHide = data;
    notifyListeners();
  }

  //Profile Manage
  void setProfileUpdateStatus({required bool data}){
    profileUpdateStatus = data;
    notifyListeners();
  }

  void setProfileUpdateNameError({String? data}){
    profileUpdateNameError = data;
    notifyListeners();
  }

  //Change Password
  void setPasswordError({required Map data}){
    passwordError = data;
    notifyListeners();
  }

  void setChangePassStatus({required bool data}){
    changePassStatus = data;
    notifyListeners();
  }




}
