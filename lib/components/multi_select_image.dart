import 'package:flutter/material.dart';
import 'package:rental_services/components/cus_image_picker.dart';
import 'package:collection/collection.dart';

class Multi_Select_Image extends StatefulWidget {
  String label;
  String? errorText;
  List? value;
  Function(List data) onChange;
  Multi_Select_Image({Key? key,required String this.label,required Function(List data) this.onChange,String? this.errorText,List? this.value}) : super(key: key);

  @override
  State<Multi_Select_Image> createState() => _Multi_Select_ImageState();
}

class _Multi_Select_ImageState extends State<Multi_Select_Image> {
  List imageList =[{'image':''}];

  @override
  void initState(){
    super.initState();
    if(widget.value!.length > 0){
      imageList = widget.value!;
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
                fontSize: 14,
                color: Colors.grey.shade600
            ),),
            ElevatedButton(
                onPressed: (){
                 setState(() {
                   imageList.add({'image':""});
                 });
                 widget.onChange(imageList);
                },
                child: Row(
                  children: [
                    Text("Add More Image"),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset("lib/assets/icons/plus.png",width: 14,color: Colors.white,)
                  ],
                )
            )
          ],
        ),
        ...imageList.mapIndexed((index,e) =>  Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10,
            ),
           if(index > 0)
             GestureDetector(
               child:  Image.asset("lib/assets/icons/cross.png",width: 19,),
               onTap: (){
                setState(() {
                  imageList.removeAt(index);
                });
                widget.onChange(imageList);
               },
             ),
            Cus_Image_Picker(setData: (value){
             setState(() {
               imageList[index]['image'] = value;
             });;
             widget.onChange(imageList);
            }, label: '',oldImage: imageList[index]['image'].toString().length == 0 ? null :imageList[index]['image'] ,),
          ],
        )).toList(),
        if(widget.errorText != null) Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(widget.errorText!,style: TextStyle(
            color: Colors.red,
            fontSize: 13,
            // fontWeight: FontWeight.bold
          ),),
        )
      ],
    );
  }
}
