import 'package:flutter/material.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/screens/Authentication/login_screen.dart';
import 'package:rental_services/theme_data/theme_data.dart';
import 'package:rental_services/screens/profile&settings/components/profile_card.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/screens/profile&settings/components/info_button.dart';
import 'package:rental_services/controller/profile_manage_controller.dart';


class Profile_Screen extends StatelessWidget {
  Profile_Screen({Key? key}) : super(key: key);
  var profileController = Profile_Manage_Controller();
  @override
  Widget build(BuildContext context) {
    return Consumer<Login_Provider>(
        builder: (context,data,child){
          return Scaffold(
              appBar: AppBar(
                title:Text("${data.loginData?['name']!}'s Profile"),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Profile_Card(),
                    Info_Button(),
                    ElevatedButton(
                        onPressed: (){profileController.showDialog(context: context);},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            )
                        ),
                        child:Row(
                          children: [
                            Image.asset("lib/assets/icons/logout.png",width: 25,color: Colors.white,),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Logout",style: TextStyle(
                                letterSpacing: 10,
                                fontSize: 16
                            ),),
                          ],
                        )
                    ),
                  ],
                ),
              )
          );
        }
    );
  }
}
