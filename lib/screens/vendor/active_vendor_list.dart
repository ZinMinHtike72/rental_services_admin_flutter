import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/screens/vendor/component/vendor_card.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:convert';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/controller/vendor_controller.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/home/search_screen.dart';

class Active_Vendor_List extends StatefulWidget {
  const Active_Vendor_List({Key? key}) : super(key: key);

  @override
  State<Active_Vendor_List> createState() => _Active_Vendor_ListState();
}

class _Active_Vendor_ListState extends State<Active_Vendor_List> {
  final vendorController = Vendor_Controller();
  final PagingController _pagingController = Vendor_Controller().getActivePagingController();

  void changeStatus(String id,bool value){
    vendorController.changeStatus(context: context, data: false,id:id);
  }
  @override
  void initState(){
    vendorController.getActivePagingController().addPageRequestListener((pageKey) {
     vendorController.getActiveVendorWithPagination(data: pageKey, context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Active Vendor List"),
        actions: [
          App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png",route: Search_Screen(type: 'activeVendor',),),
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:  Consumer<Vendor_Provider>(
            builder: (context,data,child){
              return data.activeVendorList.length == 0 ? No_Data(alertText: "No Active Vendor Here !") :  PagedGridView(
                pagingController: vendorController.getActivePagingController(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                builderDelegate: PagedChildBuilderDelegate(
                  newPageProgressIndicatorBuilder: (context){
                    return  Opacity(
                      opacity: 0.1,
                      child: Loading_Screen(),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context){
                    return Loading_Screen();
                  },
                  firstPageErrorIndicatorBuilder: (context){
                    return Error_Screen();
                  },
                  itemBuilder: (context, item, index) => Vendor_Card(data: data.activeVendorList[index],isShow: true,onChanged: changeStatus,),
                ),
              );
            }
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _pagingController.dispose();
  }

}
