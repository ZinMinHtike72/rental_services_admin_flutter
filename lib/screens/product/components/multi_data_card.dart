import 'package:flutter/material.dart';

class Multi_Data_Card extends StatelessWidget {
  String data;
  Multi_Data_Card({Key? key,required String this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(10)

      ),
      child: Text("$data",style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 3
      ),),
    );
  }
}
