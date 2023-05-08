import 'package:flutter/material.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/product/product_add.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/product/components/product_card.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/controller/product_controller.dart';

class Product_List extends StatefulWidget {
  const Product_List({Key? key}) : super(key: key);

  @override
  State<Product_List> createState() => _Product_ListState();
}

class _Product_ListState extends State<Product_List> {
  Product_Controller controller = Product_Controller();
  Future<void> _refreshFunction() async{
    // setState(() {
    //   getData = context.read<Product_Provider>().getProduct();
    // });
  }
  @override
  void initState(){
    controller.getProductPagingController().addPageRequestListener((pageKey) {
      controller.getProductWithPagination(context: context, pageNum: pageKey);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshFunction,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Product"),
          actions: [
            App_Bar_Action_Button(iconImage: "lib/assets/icons/plus.png" , route:Product_Add() ),
            App_Bar_Action_Button(iconImage: "lib/assets/icons/search.png" , route:Search_Screen(type: "product",) )
          ],
        ),
        body: Consumer<Product_Provider>(
            builder: (context,data,child){
              return PagedGridView(
                pagingController: controller.getProductPagingController(),
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
                    final productList = data.productList;
                    if (index >= productList.length) {
                      return const SizedBox();
                    }
                    return Product_Card(data: productList[index],);
                  },

                ),
              );
            }
        ),
        // body: FutureBuilder(
        //     future: getData,
        //     builder: (context,snapshot){
        //       if(snapshot.connectionState == ConnectionState.waiting) {
        //         return Loading_Screen();
        //       }else{
        //         if(snapshot.connectionState == ConnectionState.done){
        //           List data = context.watch<Product_Provider>().productList;
        //           if(snapshot.hasData){
        //             return data!.length == 0 ? No_Data(alertText: "No Product Here !") :GridView.builder(
        //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                     crossAxisCount: 2,
        //                     mainAxisSpacing: 10,
        //                     crossAxisSpacing: 10,
        //                     childAspectRatio: 0.9
        //                 ) ,
        //                 itemCount: data!.length ,
        //                 itemBuilder: (context,index){
        //                   return Product_Card(data: data[index],);
        //                 }
        //             );
        //           }
        //         }
        //       }
        //       return Error_Screen();
        //     }
        // ),
      ),
    );
  }
}
