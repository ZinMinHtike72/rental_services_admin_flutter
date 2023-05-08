import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Error_Screen extends StatelessWidget {
  const Error_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
        color: Colors.white,
        width: double.infinity,
        alignment: Alignment.center,
        // height: double.infinity,
        child:ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("lib/assets/animations/98119-error.json",frameRate: FrameRate(1200)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Something Wrong !",style: TextStyle(
                        fontSize: 17,
                        color: Colors.indigoAccent
                    ),),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Try Again .",style: TextStyle(
                        fontSize: 19,
                        color: Colors.redAccent
                    ),)
                  ],
                )
              ],
            ),
          ],
        ) )
    );
  }
}
