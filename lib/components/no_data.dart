import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class No_Data extends StatelessWidget {
    String alertText;
   No_Data({Key? key,required String this.alertText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Card(
        color: Colors.redAccent.shade100,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("lib/assets/animations/warning.json",width: 50),
              SizedBox(
                width: 10,
              ),
              Text(alertText,style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
