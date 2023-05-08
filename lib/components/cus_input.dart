import 'package:flutter/material.dart';


class Cus_Input extends StatefulWidget {
  final String label;
  String? value;
  String? errorText;
  bool? enabled;
  bool? obscureText;
  int? maxLine;
  String? keyboardType;
  final Function(String data) onChange;
  Cus_Input({Key? key,required String this.label,required Function(String data) this.onChange,String? this.errorText,String? this.value,bool? this.enabled,bool? this.obscureText,int? this.maxLine, String? this.keyboardType}) : super(key: key);
  @override
  State<Cus_Input> createState() => _Cus_InputState();
}

class _Cus_InputState extends State<Cus_Input> {
  final _textController = TextEditingController();
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _textController.text = widget.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey.shade600
        ),),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: widget.obscureText ?? false,
          enabled: widget.enabled ?? true,
          controller: _textController,
          maxLines: widget.maxLine ?? 1,
          keyboardType: widget.keyboardType == null ? TextInputType.text :  TextInputType.number,
          onChanged:(String data){
            widget.onChange(data);
          },
          style: TextStyle(
              fontSize: 15
          ),
          decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.black.withOpacity(0.2),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey.shade50
                  )
              ),
              errorText: widget.errorText
          ),
        )
      ],
    );
  }
}


