import 'package:flutter/material.dart';
import 'package:rental_services/theme_data/theme_data.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_services/components/input_decoration.dart';
import 'package:rental_services/screens/Authentication/components/auth_button.dart';
import "package:rental_services/reuseable_functions/reuseable_function.dart";
import 'package:rental_services/screens/Authentication/login_screen.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/screens/home/main_screen.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/controller/register_controller.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}
class _Register_ScreenState extends State<Register_Screen> {
  var registerController =  Register_Controller();
  // final _nameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  // bool _status = false;
  // bool _isHide = true;
  // Map<String,String> validateError = {
  //   "email" : "",
  //   "password":"",
  //   "name":"",
  //   "confirmPassword":""
  // };

  // void register() async{
  //   // debugPrint(Constant_Api.registerApi);
  //
  //   bool checkIsHaveEmail = Reuseable_Function.checkIsHave(value: _emailController.text);
  //   bool checkIsHavePassword = Reuseable_Function.checkIsHave(value: _passwordController.text);
  //   bool checkIsHaveName =  Reuseable_Function.checkIsHave(value: _nameController.text);
  //   bool checkIsHaveConfirmPass = Reuseable_Function.checkIsHave(value: _confirmPasswordController.text);
  //   if(!checkIsHavePassword || !checkIsHaveEmail || !checkIsHaveConfirmPass ||!checkIsHaveConfirmPass){
  //     setState(() {
  //       validateError['email'] = checkIsHaveEmail ? "" : "Need To Fill The Email !";
  //       validateError['password'] = checkIsHavePassword ? "" : "Need To Fill The Password";
  //       validateError['name'] = checkIsHaveName ? "" : "Need To Fill The Name !";
  //       validateError['confirmPassword'] = checkIsHaveConfirmPass ? '' : 'Need To Fill The Confirm Password !';
  //     });
  //   }else{
  //     bool checkIsEmail = Reuseable_Function.checkIsEmail(value: _emailController.text);
  //     if(!checkIsEmail || _passwordController.text.length < 8){
  //       setState(() {
  //         validateError['name'] ="";
  //         validateError['email'] = checkIsEmail ? "" : "Your Email Is Invalid !";
  //         validateError['password'] = _passwordController.text.length > 8 ? "" : "Password Must Be At Least 8 Characters !";
  //       });
  //     }else{
  //       setState(() {
  //         validateError['email'] = "";
  //       });
  //       if(_passwordController.text != _confirmPasswordController.text){
  //         setState(() {
  //           validateError['password'] = _passwordController.text == _confirmPasswordController.text? "" : "Password & Confirm Password Not Match !";
  //         });
  //       }else{
  //         setState(() {
  //           validateError['password'] = '';
  //           _status = true;
  //         });
  //        final Map sendData = {
  //          "name":_nameController.text,
  //          "email":_emailController.text,
  //          "password":_passwordController.text
  //        };
  //         final Map data = await Api_Services.postMethod(data: sendData, path: Constant_Api.registerApi);
  //         print(data);
  //         if(!data['error']){
  //           setState(() {
  //             validateError['password'] = '';
  //             _status = false;
  //           });
  //           Storage_Services.setLoginData(data: data['data']);
  //           context.read<Login_Provider>().setLoginData(data: data['data']);
  //           Api_Services.setLoginData(data['data']);
  //           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Main_Screen()));
  //           Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Register Success !", status: 'success');
  //         }else{
  //           setState(() {
  //             _status = false;
  //           });
  //           if(data['too_many'] != null){
  //             Alert_Dialog.Cus_Snackbar(context: context, label: data['message'],bgColor: Colors.red);
  //           }else{
  //             Alert_Dialog.Cus_Snackbar(context: context, label: data['data']['email'][0],bgColor: Colors.red);
  //           }
  //
  //         }
  //       }
  //     }
  //   }
  // }
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Lottie.asset('lib/assets/animations/register.json',height: 200),
                          SizedBox(
                            height: 25,
                          ),
                          Text("Register To Rental Service",style: TextStyle(
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
                              key: registerController.getFormKey(),
                              child: Column(
                                children: [
                                  Input_Decoration(
                                    errorText: data.registerError['name'],
                                    child: TextField(
                                      controller:registerController.getNameController(),
                                      style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 17
                                      ),
                                      decoration: InputDecoration(
                                          hintText: "Name",
                                          hintStyle: TextStyle(color: Colors.grey[300]),
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Input_Decoration(
                                    errorText: data.registerError['email'],
                                    child: TextField(
                                      controller:registerController.getEmailController(),
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
                                    height: 6,
                                  ),
                                  Input_Decoration(
                                    errorText: data.registerError['password'],
                                    child: TextField(
                                      controller: registerController.getPasswordController(),
                                      obscureText: data.registerPassIsHide,
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
                                              context.read<Login_Provider>().setRegisterPassIsHide(data: !data.registerPassIsHide);
                                            },
                                            child: Image.asset(data.registerPassIsHide ? 'lib/assets/icons/view.png' : 'lib/assets/icons/hide.png',width: 20,color: Colors.grey[300],),
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Input_Decoration(
                                    errorText: data.registerError['confirmPassword'],
                                    child: TextField(
                                      controller: registerController.getConfirmPassController(),
                                      obscureText: data.registerPassIsHide,
                                      style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 17
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle: TextStyle(color: Colors.grey[300]),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Auth_Button(button_text: "Register",icon: 'lib/assets/icons/verify.png',clickFun: (){registerController.register(context: context);},status: data.registerStatus,loadingStatus: 'Registering',),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already Have An Account ?",style: TextStyle(color: Colors.white),),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login_Screen()));
                                        },
                                        child: Text(
                                          'Login Here !',
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
                )
            ),
          );
        }
    );
  }
}
