import 'package:flutter/material.dart';

class Back_Button extends StatelessWidget {
  const Back_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.of(context).pop();
      } ,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset("lib/assets/icons/back.png",width: 30,color: Colors.indigo,),
      ),
    );
  }
}
