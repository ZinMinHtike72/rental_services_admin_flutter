import 'package:flutter/material.dart';

class Loading_Button extends StatelessWidget {
  final String label;
  final bool status;
  final String loadingStatus;
  final Function onPressed;
  Loading_Button({required this.label,required this.status,required this.loadingStatus,required this.onPressed}) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: status ?  (){} : (){
            onPressed();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)
              ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              primary: Colors.indigoAccent.withOpacity(0.8),
              elevation: 3
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(!status)Text(
                label,
                style:TextStyle(
                    fontSize: 20,
                    letterSpacing:2,
                    fontWeight: FontWeight.bold
                ),
              ),
              if(status)Row(
                children: [
                  Text(loadingStatus,style:TextStyle(
                      fontSize: 20,
                      letterSpacing:2,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}

