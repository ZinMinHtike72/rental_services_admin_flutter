import 'package:flutter/material.dart';
import 'package:rental_services/screens/vendor/component/for_show_list.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_services/models/vendor_model.dart';
class Main_Vendor_Page extends StatelessWidget {
  const Main_Vendor_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor List"),
      ),
      body: Column(
        children: [
          Expanded(
            child:  FutureBuilder(
                future: context.read<Vendor_Provider>().getActiveVendorList(page: 1),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.26,
                      alignment: Alignment.center,
                      child: Lottie.asset("lib/assets/animations/loading.json",width: 100),
                    );
                  }else{
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasData){
                        List<Vendor_Model> data = context.watch<Vendor_Provider>().previewActiveVendorList;
                        return data.length == 0 ?  vendorError(label: 'Active Vendor List',errorText: "No Active Vendor Here !") : For_Show_List(label: "Active Vendor List" ,data: data,type: "active",);
                      }
                    }
                  }
                  return vendorError(label: "Active Vendor List");
                }
            ),
          ),
          Expanded(
            child:  FutureBuilder(
                future: context.read<Vendor_Provider>().getInactiveVendor(page: 1),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.26,
                      alignment: Alignment.center,
                      child: Lottie.asset("lib/assets/animations/loading.json",width: 100),
                    );
                  }else{
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasData){
                        List<Vendor_Model> data = context.watch<Vendor_Provider>().previewInactiveVendorList;
                        // No_Data(alertText: "No Vendor Here !")
                        return data.length == 0 ? vendorError(label: 'Inactive Vendor List',errorText: "No Inactive Vendor Here !")  : For_Show_List(label: "Inactive Vendor List" ,data: data,type: 'inactive',);
                      }
                     }
                  }
                  return vendorError(label: "Inactive Vendor List");
                }
            ),
          ),
        ],
      ),
    );
  }
}

Widget vendorError ({required String label,String? errorText}){
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$label",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),),
          ],
        ),
      ),
     Container(
       margin: EdgeInsets.symmetric(horizontal: 10),
       decoration: BoxDecoration(
         color: Colors.red.withOpacity(0.5),
         borderRadius: BorderRadius.circular(8),
       ),
       child:  Row(
         children: [
           Lottie.asset("lib/assets/animations/warning.json",width: 80),
           SizedBox(
             width: 10,
           ),
           Text(errorText ?? "Something Wrong . Try Again ! ",style: TextStyle(
             color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),)
         ],
       ),
     )
    ],
  );
}

