import 'package:flutter/material.dart';
import 'package:rental_services/screens/business/business_add.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/business/components/business_card.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/controller/business_controller.dart';

class Business_List extends StatefulWidget {
  const Business_List({Key? key}) : super(key: key);

  @override
  State<Business_List> createState() => _Business_ListState();
}

class _Business_ListState extends State<Business_List> {
  Business_Controller controller = Business_Controller();
  Future<void> _refresh() async{
    // setState(() {
    //   getData = context.read<Business_Provider>().getBusinessList();
    // });
  }
  @override
  void initState(){
    controller.getBusinessPagingController().addPageRequestListener((pageKey) {
        controller.getBusinessWithPagination(context: context, pageNum: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Business"),
        actions: [
          App_Bar_Action_Button(iconImage: "lib/assets/icons/plus.png",route:Business_Add() ,),
          App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png",route: Search_Screen(type: 'business',),)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Consumer<Business_Provider>(
            builder: (context,data,child){
              return  PagedGridView(
                pagingController: controller.getBusinessPagingController(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
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
                  itemBuilder: (context, item,index){
                    final businessList = data.businessList;
                    if (index >= businessList.length) {
                      return const SizedBox();
                    }
                    return Business_Card(data: businessList[index],);
                  },

                ),
              );
            }
        ),
        // child: FutureBuilder(
        //     future: getData,
        //     builder: (context,snapshot){
        //       if(snapshot.connectionState == ConnectionState.waiting)
        //         return Loading_Screen();
        //       if(snapshot.connectionState == ConnectionState.done){
        //         List data = context.watch<Business_Provider>().businessList;
        //         if(snapshot.hasData){
        //           return data!.length == 0 ?   No_Data(alertText: "No Brand Here !") :   GridView.builder(
        //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                   crossAxisCount: 2,
        //                   mainAxisSpacing: 10,
        //                   crossAxisSpacing: 10,
        //                   mainAxisExtent: 210
        //               ) ,
        //               itemCount: data.length,
        //               itemBuilder: (context,index){
        //                 return Business_Card(data: data[index],);
        //               }
        //           );
        //         }
        //       }
        //       return  Error_Screen();
        //     }
        // ),
      )
    );
  }
}
