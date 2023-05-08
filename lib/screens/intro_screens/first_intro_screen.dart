import 'package:flutter/material.dart';
import 'package:rental_services/theme_data/theme_data.dart';
import 'package:lottie/lottie.dart';

class First_Intro_Screen extends StatelessWidget {
    Function() onClick;
   First_Intro_Screen({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Lottie.asset('lib/assets/animations/welcome.json'),
          SizedBox(
            height: 20,
          ),
          Text("Welcome To Our Services",style: TextStyle(
            color: Colors.white,
            fontSize: 29,
            fontWeight: FontWeight.bold
          ),),
          const SizedBox(
              height: 20,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s . ",
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 16
            ),
          ),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Container(
                   width: 130,
                   margin: EdgeInsets.only(bottom: 20),
                   child:  ElevatedButton(
                     onPressed: onClick,
                     child: Row(
                       children: [
                         Text("Next Page"),
                         SizedBox(
                           width: 8,
                         ),
                         Image.asset('lib/assets/icons/right.png',width: 17,color: Colors.white,)
                       ],
                     ),
                     style: ElevatedButton.styleFrom(
                         primary: Colors.indigoAccent
                     ),
                   ),
                 )
                ],
              )
          )

        ],
      ),
    );
  }
}
