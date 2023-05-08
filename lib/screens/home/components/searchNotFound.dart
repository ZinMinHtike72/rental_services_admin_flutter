import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class SearchNotFound extends StatelessWidget {
  const SearchNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child:Column(
          children: [
            Lottie.asset("lib/assets/animations/searchNotFound.json"),
            SizedBox(
              height: 10,
            ),
            Text("No Data Here !",style: TextStyle(
              color: Colors.indigoAccent,
              fontSize: 20,
            ),)
          ],
        )
    );
  }
}
