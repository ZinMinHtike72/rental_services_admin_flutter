import 'package:flutter/material.dart';

class Auth_Button extends StatelessWidget {
  final String button_text;
  final String icon;
  final Function clickFun;
  final bool status;
  final String loadingStatus;
  Auth_Button({required this.button_text,required this.icon,required this.clickFun,required this.status,required this.loadingStatus});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:!status?  (){
        clickFun();
      }: (){},
      child: Container(
        // width: !status ?  160 : 210,
        child: !status ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(button_text,style: TextStyle(fontSize:18,letterSpacing: 7 ),),
            SizedBox(
              width: 7,
            ),
            Image.asset(icon,width: 20,color: Colors.white,)
          ],
        ): Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loadingStatus,style:TextStyle(
                fontSize: 20,
                letterSpacing:6,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.indigoAccent[200],
          padding: EdgeInsets.symmetric(horizontal: 26,vertical: 10),
          shadowColor: Colors.indigoAccent,
          elevation: 4
      ),
    );
  }
}
