import 'package:flutter/material.dart';
import 'package:rental_services/models/count_model.dart';
import 'dart:ui';
import 'dart:math';


class Count_Card extends StatelessWidget {
  Count_Model data;
  Count_Card({Key? key,required Count_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigoAccent.withOpacity(0.5),
                  Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.6),
                  Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.2)
                ],
              )
            ),
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          ),
          BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1000,
                sigmaY: 100
              ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data.name.toUpperCase(),style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4
                ),),
                SizedBox(
                  height: 8,
                ),
                Text(data.count.toString(),style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
