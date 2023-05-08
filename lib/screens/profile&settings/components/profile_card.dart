import 'package:flutter/material.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:rental_services/screens/profile&settings/profile_manage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class Profile_Card extends StatelessWidget {
  String? image;
  Profile_Card({Key? key,String? this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<Login_Provider>(
        builder:(context,data,child){
          return Card(
            elevation: 3,
            shadowColor: Colors.indigoAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: data.loginData?['profile'] == null ? Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.indigoAccent,
                          ),
                          child: Image.asset("lib/assets/icons/user.png",width: 40,color: Colors.white,),
                        ): Container(
                          width: 90,
                          height: 90,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.indigoAccent,
                            image: DecorationImage(image: NetworkImage(data.loginData!['profile']),fit: BoxFit.cover)
                          ),
                      ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.loginData?['name'] ?? "",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                data.loginData?['email'] ?? "",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.grey.shade700
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: (){
                                  PersistentNavBarNavigator.pushDynamicScreen(context, screen: MaterialPageRoute(builder: (context)=>Profile_Manage()),withNavBar: false);
                                },
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  ),

                ],
              ),
            ),
          );
        }
      )
    );
  }
}
