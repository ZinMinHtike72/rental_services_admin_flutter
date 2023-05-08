import 'package:flutter/material.dart';

class Price_Card extends StatelessWidget {
  String data;
  String type;
  Price_Card({Key? key,required String this.data,required String this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal:30,vertical: 15),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.indigoAccent.shade400.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.indigo.shade900
        ),
        boxShadow:[
          BoxShadow(
              color: Colors.indigoAccent.withOpacity(0.7),
              offset: Offset(2,2),
              spreadRadius: 1,
              blurRadius: 5
          )
        ]
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "$type : ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400
                )
            ),
            TextSpan(
                text: "$data",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400
                )
            ),
            TextSpan(
                text: " ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                )
            ),
          ]
        ),
      )
    );
  }
} 
