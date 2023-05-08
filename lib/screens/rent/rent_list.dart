import 'package:flutter/material.dart';
import 'package:rental_services/controller/rent_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/providers/rent_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/rent/components/rent_card.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/home/search_screen.dart';
class Rent_List extends StatefulWidget {
  const Rent_List({Key? key}) : super(key: key);

  @override
  State<Rent_List> createState() => _Rent_ListState();
}

class _Rent_ListState extends State<Rent_List> {
  Rent_Controller rentController = Rent_Controller();
  @override
  void initState(){
    rentController.getRentPagingController().addPageRequestListener((pageKey) {
      rentController.getRentListWithPagination(context: context,pageNum: pageKey);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rent User List"),
        actions: [
          App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png", route: Search_Screen(type: 'rent',))
        ],
      ),
      body: Consumer<Rent_Provider>(
          builder: (context,data,child){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              height: MediaQuery.of(context).size.height,
              child: PagedListView(
                pagingController: rentController.getRentPagingController(),
                builderDelegate: PagedChildBuilderDelegate(
                  newPageProgressIndicatorBuilder: (context){
                    return Container(
                      height: 100,
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
                    final rentList = data.rentList;
                    if (index >= rentList.length) {
                      return const SizedBox();
                    }
                    return Rent_Card(data: rentList[index],);
                  },

                ),
              ),
            );
          })
    );
  }
  
  @override
  void dispose(){
    rentController.getRentPagingController().dispose();
    super.dispose();
  }
  
}
