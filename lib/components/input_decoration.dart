import 'package:flutter/material.dart';


class Input_Decoration extends StatefulWidget {
  final Widget child;
  final errorText;
  const Input_Decoration({required this.child, String? this.errorText});
  @override
  State<Input_Decoration> createState() => _Input_DecorationState();
}

class _Input_DecorationState extends State<Input_Decoration> {
  bool isFocus = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: isFocus ? Colors.white :Colors.transparent),
                borderRadius: BorderRadius.circular(8),
                color: Colors.indigoAccent.shade100.withOpacity(0.8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.indigo,
                      offset: Offset(1,2),
                      blurRadius: 1,
                      spreadRadius: 1
                  )
                ]
            ),
            child: widget.child,

        ),

        SizedBox(
          height: 10,
        ),
        if(widget.errorText != null) Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(widget.errorText,style: TextStyle(
            color: Colors.red,
            fontSize: 13,
            // fontWeight: FontWeight.bold
          ),),
        )
      ],
    );
  }
}


