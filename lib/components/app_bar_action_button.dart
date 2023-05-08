import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class App_Bar_Action_Button extends StatelessWidget {
  final String iconImage;
  final Widget route;
   double? width;
   App_Bar_Action_Button({Key? key,required String this.iconImage,required Widget this.route,double? this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushDynamicScreen(context, screen:  MaterialPageRoute(builder: (context)=>route),withNavBar: false);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        child: Image.asset(iconImage,color: Colors.white,width: width ??  20,),
      ),
    );
  }
}
