import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/Brand/brand_add.dart';
import 'package:rental_services/screens/Brand/components/brand_card.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/controller/brand_controller.dart';
import 'package:rental_services/models/brand_model.dart';

class Brand_List extends StatefulWidget {
  const Brand_List({Key? key}) : super(key: key);
  @override
  State<Brand_List> createState() => _Brand_ListState();
}

class _Brand_ListState extends State<Brand_List> {
  final brandController = Brand_Controller();
  // late List data;
  Future<void> _refresh() async{
    brandController.getBrandPaging().refresh();
  }

  @override
  void initState(){
    brandController.getBrandPaging().addPageRequestListener((pageKey) {
      brandController.getBrandWithPagination(context: context, pageKey: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brand"),
        actions: [
          App_Bar_Action_Button(iconImage: "lib/assets/icons/plus.png",route:Brand_Add() ,),
          App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png",route: Search_Screen(type: 'brand',),)
        ],
      ),
      body: RefreshIndicator(
        onRefresh:_refresh,
        child:Consumer<Brand_Provider>(
            builder: (context,data,child){
              return  PagedGridView(
                pagingController: brandController.getBrandPaging(),
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
                    final brandList = data.brandList;
                    if (index >= brandList.length) {
                      return const SizedBox();
                    }
                    return Brand_Card(
                      name: brandList[index].name,
                      image: brandList[index].media!.media_link,
                      id: brandList[index].id,
                    );
                  },

                ),
              );
            }
        ),
      ),
    );
  }
}


