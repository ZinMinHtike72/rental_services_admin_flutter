import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/category/category_add.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/screens/category/components/category_card.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/controller/category_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/models/category_model.dart';

class Category_List extends StatefulWidget {
  const Category_List({Key? key}) : super(key: key);
  @override
  State<Category_List> createState() => _Category_ListState();
}

class _Category_ListState extends State<Category_List> {
  Category_Controller controller = Category_Controller();
  @override
  void initState(){
    super.initState();
    controller.getPagingController().addPageRequestListener((pageKey) {
      controller.getCategoryWithPagination(context: context, data: pageKey);
    });
  }

  Future<void> _refresh() async{
    controller.getPagingController().refresh();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category") ,
        actions: [
          App_Bar_Action_Button(iconImage: "lib/assets/icons/plus.png",route:Category_Add() ,),
          App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png",route: Search_Screen(type: 'category',),)
        ],
      ),
      body:Consumer<Category_Provider>(
          builder: (context,data,child){
            return RefreshIndicator(
              onRefresh: _refresh,
              child: PagedGridView(
                pagingController: controller.getPagingController(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                builderDelegate: PagedChildBuilderDelegate<Category_Model>(
                  newPageProgressIndicatorBuilder: (context){
                    return Opacity(
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
                  itemBuilder: (context,dynamic item,index){
                    final categoryList = data.categoryList;
                    if (index >= categoryList.length) {
                      return const SizedBox();
                    }
                    return Category_Card(
                      name: categoryList[index].name,
                      image:categoryList[index].media!,
                      id: categoryList[index].id,
                    );
                  },
                ),
              ),
            );
          }
      ),
    );
  }
}
