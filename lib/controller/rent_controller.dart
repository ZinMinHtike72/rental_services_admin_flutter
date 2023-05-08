import 'package:flutter/material.dart';
import 'package:rental_services/providers/rent_provider.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Rent_Controller{
  int limit = 10;
  PagingController _rentPagingController = PagingController(firstPageKey: 1);
  PagingController getRentPagingController(){
    return _rentPagingController;
  }
  void getRentListWithPagination({required BuildContext context,required int  pageNum}) async{
    final Map resData = await context.read<Rent_Provider>().getRentList(pageNum: pageNum);
    final int newList = resData['newList'];
    print("======passs $resData");
    if(newList < limit){
      _rentPagingController.appendLastPage(resData['dataList']);
    }else{
      _rentPagingController.appendPage(resData['dataList'], pageNum + 1);
    }
    _rentPagingController.itemList = resData['dataList'];
  }

}