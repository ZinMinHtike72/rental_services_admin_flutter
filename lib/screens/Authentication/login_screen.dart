import 'package:flutter/material.dart';
import 'package:rental_services/theme_data/theme_data.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_services/components/input_decoration.dart';
import 'package:rental_services/screens/Authentication/components/auth_button.dart';
import "package:rental_services/reuseable_functions/reuseable_function.dart";
import 'package:rental_services/screens/Authentication/register_screen.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/screens/home/main_screen.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/controller/login_controller.dart';


class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var loginController = Login_Controller();
  @override
  Widget build(BuildContext context) {
    return Consumer<Login_Provider>(
        builder: (context,data,child){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  color: bgColor,
                  child: Column(
                    children: [
                      Lottie.asset('lib/assets/animations/shop_login.json'),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Login To Rental Service",style: TextStyle(
                          color:Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                      ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Form(
                          key: loginController.getFormKey() ,
                          child: Column(
                            children: [
                              Input_Decoration(
                                errorText: data.loginError['email'],
                                child: TextField(
                                  controller:loginController.getEmailController(),
                                  style:TextStyle(
                                      color: Colors.white,
                                      fontSize: 17
                                  ),
                                  decoration: InputDecoration(
                                      hintText: "test@example.com",
                                      hintStyle: TextStyle(color: Colors.grey[300]),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Input_Decoration(
                                errorText: data.loginError['password'],
                                child: TextField(
                                  controller: loginController.getPasswordController(),
                                  obscureText: data.loginPassIsHide,
                                  style:TextStyle(
                                      color: Colors.white,
                                      fontSize: 17
                                  ),
                                  decoration: InputDecoration(
                                      hintText: "password",
                                      hintStyle: TextStyle(color: Colors.grey[300]),
                                      border: InputBorder.none,
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 28
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: (){
                                          context.read<Login_Provider>().setLoginPassIsHide(data: !data.loginPassIsHide);
                                        },
                                        child: Image.asset(data.loginPassIsHide ? 'lib/assets/icons/view.png' : 'lib/assets/icons/hide.png',width: 20,color: Colors.grey[300],),
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Auth_Button(button_text: "Login",icon: 'lib/assets/icons/login.png',clickFun: (){loginController.login(context: context);},status: data.loginStatus,loadingStatus: 'Logging',),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You Don't Have An Account ?",style: TextStyle(color: Colors.white),),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Register_Screen()));
                                    },
                                    child: Text(
                                      'Register Here !',
                                      style: TextStyle(
                                          color: Colors.indigo.shade900,
                                          decoration: TextDecoration.underline
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }
}
