import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/components/alert_dialog.dart';

class Vendor_Controller{
    int pageLimit = 10;
    final PagingController _activePagingController = PagingController(firstPageKey: 1);
    final PagingController _inactivePagingController = PagingController(firstPageKey: 1);
    PagingController getActivePagingController(){
      return _activePagingController;
    }

    PagingController getInactivePagingController(){
      return _inactivePagingController;
    }

    ///Data Mean Page Number
    Future<void> getActiveVendorWithPagination({required data,required BuildContext context}) async{
      final List resData = await context.read<Vendor_Provider>().getActiveVendorList(page: data);
      if(resData.length < pageLimit){
        _activePagingController.appendLastPage(resData);
      }else{
        _activePagingController.appendPage(resData,data + 1);
      }
    }

    Future<void> getInactiveVendorWithPagination({required  data,required BuildContext context}) async{
      final List resData = await context.read<Vendor_Provider>().getInactiveVendor(page: data);
      if(resData.length < pageLimit){
        _inactivePagingController.appendLastPage(resData);
      }else{
        _inactivePagingController.appendPage(resData, data+1);
      }
    }

    void changeStatus({required BuildContext context,required bool data,required String id}) async{
      final resData;
      if(!data){
        resData = await Api_Services.postMethod(data: {
          "vendor_id" : id
        }, path: Constant_Api.inactiveVendorProcess);
      }else{
       resData = await Api_Services.postMethod(data: {
          'vendor_id' : id
        }, path: Constant_Api.activeVendorProcess);
      }
      if(!resData['error']){
        Alert_Dialog.Cus_Snackbar(context: context, label: "Change Status Success");
        context.read<Vendor_Provider>().changeDataWhenStatusChange(id: id, data: data,controller:data ?  _inactivePagingController : _activePagingController );
      }
    }


}