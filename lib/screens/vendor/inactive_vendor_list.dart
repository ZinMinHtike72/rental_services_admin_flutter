import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/screens/vendor/component/vendor_card.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/controller/vendor_controller.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/components/app_bar_action_button.dart';

class Inactive_Vendor_List extends StatefulWidget {
  const Inactive_Vendor_List({Key? key}) : super(key: key);

  @override
  State<Inactive_Vendor_List> createState() => _Inactive_Vendor_ListState();
}

class _Inactive_Vendor_ListState extends State<Inactive_Vendor_List> {
  final vendorController = Vendor_Controller();
  final _pagingController = Vendor_Controller().getInactivePagingController();


  void changeStatus(String id,bool value){
    vendorController.changeStatus(context: context, data: value,id:id);
  }
  @override
  void initState(){
    super.initState();
    vendorController.getInactivePagingController().addPageRequestListener((pageKey) {
      vendorController.getInactiveVendorWithPagination(data: pageKey, context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Inactive Vendor List"),
        actions: [
          App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png",route: Search_Screen(type: 'inactiveVendor',),),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Consumer<Vendor_Provider>(
            builder: (context,data,child){
              return data.inActiveVendor.length == 0 ? No_Data(alertText: "No Inactive Vendor Here !") :PagedGridView(
                pagingController: vendorController.getInactivePagingController(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.76,
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
                  itemBuilder: (context, item, index) => Vendor_Card(data: data.inActiveVendor[index],isShow: true,onChanged: changeStatus,),
                ),
              );
            }
        ),
      ),
    );
  }
}


