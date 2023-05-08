import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/screens/category/category_add.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:rental_services/controller/category_controller.dart';


class Category_Details extends StatelessWidget {
  Category_Details({Key? key}) : super(key: key);
  var categoryController = Category_Controller();

  @override
  Widget build(BuildContext context){
    return Consumer<Category_Provider>(
        builder: (context,data,child){
          return Scaffold(
            appBar: AppBar(
              title: Text("${data.categoryDetails?.name}"),
              actions: [
                App_Bar_Action_Button(iconImage: "lib/assets/icons/update.png",route:Category_Add(data: data.categoryDetails,),width: 25 ,),
                GestureDetector(
                    onTap: (){categoryController.showDialog(context: context, name:  data.categoryDetails!.name, id:  data.categoryDetails!.id);},
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
                  child: Text("Brand  :  ${data.categoryDetails!.brand!.name}",textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis
                  ),),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(data.categoryDetails!.media!),fit: BoxFit.cover),
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
