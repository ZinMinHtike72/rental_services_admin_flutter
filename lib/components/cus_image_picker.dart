import 'package:flutter/material.dart';
import 'package:rental_services/components/input_decoration.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';


class Cus_Image_Picker extends StatefulWidget {
  final Function(dynamic?) setData;
  String? errorText;
  final String label;
  String? oldImage;
  Cus_Image_Picker({required this.setData,String? this.errorText,required String this.label,String? this.oldImage});

  @override
  State<Cus_Image_Picker> createState() => _Cus_Image_PickerState();
}

class _Cus_Image_PickerState extends State<Cus_Image_Picker> {
  final ImagePicker picker = ImagePicker();
  XFile? fileImage = null;
  void getImage () async{
    final  image = await picker.pickImage(source:ImageSource.gallery);
    if(image == null) return;
    setState(() {
      fileImage = image;
    });
    final byteImage = await image.readAsBytes();
    widget.setData("data:image/png;base64," + base64Encode(byteImage));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.label != '')
            Column(
              children: [Text(widget.label,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade600
              ),),
                SizedBox(
                  height: 10,
                ),],
            ),
          fileImage !=  null ?   Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(fileImage!.path))),
            ),
          ) : widget.oldImage != null ?Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.oldImage!),
            ),
          ) ,
          ) : Container(),
          SizedBox(
            height: 10,
          ),
          Input_Decoration(
              errorText: widget.errorText,
              child: GestureDetector(
                onTap: getImage,
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: fileImage == null ?   Container(
                      // width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.indigo.shade900.withOpacity(0.6)),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Image.asset('lib/assets/icons/image-files.png',width: 30,),
                          SizedBox(width: 10,),
                          Text("Select Image",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),)
                        ],
                      ),
                    ) : Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child:Row(
                        children: [
                          Image.asset('lib/assets/icons/image-files.png',width: 30,),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: 60,
                            child:  Text(fileImage!.name,style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis
                            ),
                            ),
                          ),
                          Text(" . ${fileImage!.path.split(".").last}",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              overflow: TextOverflow.ellipsis
                          ),)
                        ],
                      ),
                    )
                ),
              )
          )
        ],
      ),
    );
  }
}


