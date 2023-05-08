import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/Brand/brand_add.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/controller/brand_controller.dart';

class Brand_Details extends StatelessWidget {
  Brand_Details({Key? key}) : super(key: key);
  var brandController = Brand_Controller();
  @override
  Widget build(BuildContext context){



    return Consumer<Brand_Provider>(
        builder: (context,details,child){
          return Scaffold(
            appBar: AppBar(
              title: Text("${details.brandDetails?.name}"),
              actions: [
                App_Bar_Action_Button(iconImage: "lib/assets/icons/update.png",route:Brand_Add(data:details.brandDetails,),width: 25 ,),
                GestureDetector(
                    onTap: (){brandController.showDialog(context: context,name: details!.brandDetails!.name!,id: details!.brandDetails!.id );},
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
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  height: 300,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(details!.brandDetails!.media!.media_link),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)
                  ),

                )
              ],
            ),
          );
        }
    );
  }
}
