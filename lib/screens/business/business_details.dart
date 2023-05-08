import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/business/business_add.dart';
import 'package:rental_services/controller/business_controller.dart';

class Business_Details extends StatelessWidget {
   Business_Details({Key? key}) : super(key: key);
   final businessController = Business_Controller();

  @override
  Widget build(BuildContext context) {

    return Consumer<Business_Provider>(
        builder: (context,data,child){
          return Scaffold(
            appBar: AppBar(
              title: Text("${data.businessDetails?.name}"),
              actions: [
                App_Bar_Action_Button(iconImage: "lib/assets/icons/update.png",route:Business_Add(data: data.businessDetails,),width: 25 ,),
                GestureDetector(
                    onTap:(){businessController.showDialog(context: context, name: data.businessDetails == null ? '' :data.businessDetails!.name  , id:data.businessDetails == null ? '' :data.businessDetails!.id );},
                    child:Container(
                      margin: EdgeInsets.only(right: 12),
                      child:   Image.asset("lib/assets/icons/delete.png",color: Colors.white,width: 20,),
                    )
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(image:NetworkImage(data.businessDetails!.media!.media_link),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  child: Text("Address  :  ${data.businessDetails!.address}",textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
              ],
            ),
          );
        }
    );
  }
}
