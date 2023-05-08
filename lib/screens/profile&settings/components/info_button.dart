import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Info_Button extends StatelessWidget {
  const Info_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    iconPadding: EdgeInsets.symmetric(horizontal: 90,vertical: 10),
                    icon:  Lottie.asset("lib/assets/animations/65770-info-icon-wave.json",width: 10),
                    title: Text("About Rental Service",textAlign: TextAlign.start,style: TextStyle(
                        color: Colors.indigoAccent
                    ),),
                    content: Container(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("App Version : 1.0.0",style: TextStyle(
                            color: Colors.indigoAccent.shade200
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Lorem Ipsum isrem Ipsum has been the industry's standard dummy text ever since the 1500s",style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12
                          ),)
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text("Close")
                      ),
                      // ElevatedButton(
                      //     onPressed: () async{
                      //       final url = "https://portfolio-zin-min-htike.netlify.app";
                      //       if (await canLaunch(url)) {
                      //         await launch(url);
                      //       } else {
                      //         throw 'Could not launch $url';
                      //       }
                      //     },
                      //     child: Text("Contact")
                      // )
                    ],
                  );
                });
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.indigoAccent.withOpacity(0.6) ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
            )
        ),
        child:Row(
          children: [
            Image.asset("lib/assets/icons/information-button.png",width: 25,color: Colors.white,),
            SizedBox(
              width: 7,
            ),
            Text("AppInfo ",style: TextStyle(
                fontSize: 16
            ),),
          ],
        )
    );
  }
}
