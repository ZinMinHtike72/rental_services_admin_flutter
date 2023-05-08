import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/screens/home/home_screen.dart';
import 'package:rental_services/theme_data/theme_data.dart';
import 'package:rental_services/screens/profile&settings/profile_screen.dart';
import 'package:rental_services/screens/create_list/main_list_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class Main_Screen extends StatefulWidget {
  const Main_Screen({Key? key}) : super(key: key);
  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  var _currentPage = 0;
  PersistentTabController _controller =PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.systemIndigo,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_tree_sharp),
        title: ("List"),
        activeColorPrimary: CupertinoColors.systemIndigo,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_pin),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.systemIndigo,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> screenList = [
      Home_Screen(),
      Main_List_Screen(),
      Profile_Screen(),
    ];
    return Scaffold(
      body: PersistentTabView(
          context,
          navBarHeight: 70,
          controller: _controller,
          screens: screenList,
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: true,
          popAllScreensOnTapOfSelectedTab: true,
          navBarStyle: NavBarStyle.style9,
          decoration: NavBarDecoration(
            border:Border.all(color: Colors.indigoAccent)
          ),
        ),
    );
  }
}


