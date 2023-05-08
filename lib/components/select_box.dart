import 'package:flutter/material.dart';


class Select_Box extends StatefulWidget {
  String label;
  String? errorText;
  List list;
  bool? fetchStatus;
  Map? value;
  Function(String data) onChanged;
  Select_Box({Key? key,required String this.label,String? this.errorText,bool? this.fetchStatus,required List this.list ,required Function(String data) this.onChanged,Map? this.value}) : super(key: key);
  @override
  State<Select_Box> createState() => _Select_BoxState();
}

class _Select_BoxState extends State<Select_Box> {
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
          height: 10
        ),
        GestureDetector(
          onTap: (){
            showBottomSheet(
                context: context,
                builder: (context){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    ),
                    height: 400,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.label,style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 18
                            ),),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Image.asset("lib/assets/icons/cross.png",width: 20,),
                            ),
                          ],
                        ),
                        Divider(
                          height: 30,
                          color: Colors.indigoAccent,
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: GridView.builder(
                                itemCount: widget.list.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 40,mainAxisSpacing: 10),
                                itemBuilder: (context,index){
                                  return GestureDetector(
                                    onTap: (){
                                      widget.onChanged(widget.list[index]['id']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: widget.value?['id'] == widget.list[index]['id'] ? Colors.indigoAccent : Colors.transparent ,
                                          border: Border.all(
                                            color: Colors.indigoAccent,
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text("${widget.list[index]['name']}",style: TextStyle(
                                        color: widget.value?['id'] == widget.list[index]['id'] ? Colors.white : Colors.black
                                      ),),
                                    ),
                                  );
                                }
                            )
                        )
                      ],
                    ),
                  );
                }
            );
          },
          child:  Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent.shade100,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(
                   children: [
                     Text(widget.value?['id'] == null ? widget.label : widget.value?['name'],style: TextStyle(
                         fontSize: 15,
                         color: Colors.white,
                         overflow: TextOverflow.ellipsis
                     ),),
                     SizedBox(
                       width: 8,
                     ),
                     if(widget.fetchStatus != null)
                       if(widget.fetchStatus!)
                         SizedBox(
                           width: 20,
                           height: 20,
                           child: CircularProgressIndicator(),
                         ),
                   ],
                 ),

                  Image.asset("lib/assets/icons/arrow.png",width: 20,color: Colors.white,)
                ],
              )
          ),
        ),
        SizedBox(
          height: 8,
        ),
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

