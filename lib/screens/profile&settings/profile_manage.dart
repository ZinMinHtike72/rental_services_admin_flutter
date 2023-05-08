import 'package:flutter/material.dart';
import 'package:rental_services/screens/profile&settings/components/profile_update.dart';
import 'package:rental_services/screens/profile&settings/components/change_password.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Profile_Manage extends StatefulWidget {
  const Profile_Manage({Key? key}) : super(key: key);
  @override
  State<Profile_Manage> createState() => _Profile_ManageState();
}

class _Profile_ManageState extends State<Profile_Manage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
     int index = 0;
    void changeIndex(){
      _tabController.animateTo(0);
    }
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Manage Profile"),
              bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          Image.asset("lib/assets/icons/user-profile.png",width: 20,color: Colors.white,),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Manage Profile",style: TextStyle(
                              color: Colors.white,
                              fontSize: 12
                          ),),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Image.asset("lib/assets/icons/password-manager.png",width: 20,color: Colors.white,),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Change Password",style: TextStyle(
                              color: Colors.white,
                              fontSize: 12
                          ),)
                        ],
                      ),
                    )
                  ]
              ),
            ),
            body:Column(
              children: [

                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: TabBarView(
                    controller: _tabController,
                      children: [
                        Profile_Update(data: context.watch<Login_Provider>().loginData!,),
                        Change_Password(changeTab: changeIndex,)
                      ]
                  ),
                )
              ],
            ),

        )
    );
  }
}
