import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading_Screen extends StatelessWidget {
  const Loading_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: double.infinity,
        child: Lottie.asset("lib/assets/animations/loading.json",frameRate: FrameRate(1200)),
      )
    );
  }
}
