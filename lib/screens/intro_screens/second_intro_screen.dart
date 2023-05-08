import 'package:flutter/material.dart';
import 'package:rental_services/theme_data/theme_data.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_services/screens/Authentication/login_screen.dart';
import 'package:rental_services/screens/Authentication/register_screen.dart';


class Second_Intro_Screen extends StatelessWidget {
  const Second_Intro_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
      child: Column(
        children: [
          Lottie.asset('lib/assets/animations/aircon.json'),
          SizedBox(
            height: 20,
          ),
          Text("Lorem Ipsum Ipsum Ipsum ",style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold
          ),),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s . ",
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[200],
                fontSize: 16
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child:  MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Register_Screen()));
                              },
                              color: Colors.white,
                              elevation: 0,
                              child: Row(
                                children: [
                                  Text("Register",style: TextStyle(
                                      color: Colors.black
                                  ),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset("lib/assets/icons/verify.png",width: 20,color: Colors.black,)
                                ],
                              )
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(BuildContext context)=>Login_Screen()));
                          },
                          child: Row(
                            children: [
                              Text("Login",style: TextStyle(
                                color: Colors.white
                              ),),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset("lib/assets/icons/login.png",width: 20,color: Colors.white,)
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.indigoAccent
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          )

        ],
      ),
    );
  }
}
