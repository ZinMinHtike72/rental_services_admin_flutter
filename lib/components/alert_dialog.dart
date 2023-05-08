import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Alert_Dialog{
  static void  Cus_Alert_Dialog({required context,required String title,String? message,required String status}){
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (context, Animation animation, Animation secondaryAnimation){
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.indigo[200],
            iconPadding: EdgeInsets.symmetric(horizontal: 120,vertical: 30),
            icon: Image.asset(status == 'success' ? "lib/assets/icons/success.png" : "lib/assets/icons/cross.png",width: 1000,),
            title: Text(title,textAlign: TextAlign.center,style: TextStyle(
              color: Colors.white
            ),),
            content: Text(message ?? ""),
          );
        });
  }

  static void Confirm_Dialog({required context,required title,String? cardIcon,Color? textColor,required String actionText,required Future<void> Function() actionFun,Color? buttonColor,String? status }){
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (context, Animation animation, Animation secondaryAnimation){
          return AlertDialog(
            backgroundColor: Colors.indigo[50],
            iconPadding: EdgeInsets.only(left: 100,right: 100,top: 20),
            icon: cardIcon == null ? Lottie.asset("lib/assets/animations/warning.json",width: 100):null,
            content: Text(title,textAlign: TextAlign.center,style: TextStyle(
                color: textColor ?? Colors.black,
                fontSize: 18
            ),),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")
              ),
              ElevatedButton(
                  onPressed: () async{
                    await actionFun();
                    Navigator.of(context).pop();
                    Alert_Dialog.Cus_Alert_Dialog(context: context, title: "$status Delete Success !", status: 'success');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor ?? Colors.indigo
                  ),
                  child: Text("$actionText")
              )
            ],
            // content: Text(message ?? ""),
          );
        });
  }
  static void Cus_Snackbar({required context,required String label,Color? bgColor}){
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content:  Text(label),
      backgroundColor: bgColor ?? Colors.indigo,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}