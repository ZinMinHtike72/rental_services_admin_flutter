import 'package:flutter/material.dart';
import 'package:collection/collection.dart';


class Multi_Input extends StatefulWidget {
  final String label;
  List? value;
  String? errorText;
  bool? enabled;
  bool? obscureText;
  final Function(List data) onChange;
  Multi_Input({Key? key,required String this.label,required Function(List data) this.onChange,String? this.errorText,List? this.value,bool? this.enabled,bool? this.obscureText}) : super(key: key);

  @override
  State<Multi_Input> createState() => _Multi_InputState();
}

class _Multi_InputState extends State<Multi_Input> {
  late List dataList;
  @override
  void initState(){
    super.initState();
    if(widget.value!.length > 0){
       dataList = widget.value!;
    }else{
      dataList = [{
        'text':""
      }];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey.shade600
            ),),
            ElevatedButton(
                onPressed: (){
                 setState(() {
                   dataList.add({'text':""});
                   widget.onChange(dataList);
                 });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1)
                ),
                child: Row(
                  children: [
                    Text("Add More",style: TextStyle(
                      fontSize: 12
                    ),),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset("lib/assets/icons/plus.png",width: 15,color: Colors.white,)
                  ],
                ))
          ],
        ),
        
        SizedBox(
          height: 10,
        ),
        ...dataList.mapIndexed((index,e){
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if(index > 0)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        dataList.removeAt(index);
                        widget.onChange(dataList);
                      });
                    },
                    child: Image.asset("lib/assets/icons/cross.png",width: 20),
                  ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.value != null && widget.value!.length > 0 ? widget.value![index]!['text']:'',
                  // initialValue: widget.value != null ? widget.value.length > 0 ? widget.value?[index]?['text'] : '' : '',
                  obscureText: widget.obscureText ?? false,
                  enabled: widget.enabled ?? true,
                  // controller: _textController,
                  onChanged:(String data){
                    print("$index ======================");
                    setState(() {
                      dataList[index]['text'] = data;
                    });
                    widget.onChange(dataList);
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
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
