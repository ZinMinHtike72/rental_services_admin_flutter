import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class Vendor_Provider with ChangeNotifier{
  List<Vendor_Model> previewActiveVendorList = [];
  List<Vendor_Model> previewInactiveVendorList = [];
  List<Vendor_Model> activeVendorList = [];
  List<Vendor_Model> inActiveVendor = [];
  Vendor_Model? vendor_details;
  Future<List> getActiveVendorList({required int page}) async{
    final resData = await Api_Services.getMethod(path: Constant_Api.activeVendorList,queryParameter:{'limit':5,'page' : page} );
    final data = resData['data'];
      if(page == 1){
        previewActiveVendorList = [];
        activeVendorList = [];
      }
      if(!resData['error']){
          for(var i = 0 ; i < data.length; i++){
            activeVendorList.add(Vendor_Model.fromJson(data[i]));
            if(page == 1){
              previewActiveVendorList.add(Vendor_Model.fromJson(data[i]));
            }
          }
      }
    notifyListeners();
    return data;
  }

  Future<List> getInactiveVendor({required int page}) async{
    final resData = await Api_Services.getMethod(path: Constant_Api.inActiveVendorList,queryParameter:{'limit':5,'page':page});
    final data  = resData['data'];
    if(page == 1){
      previewInactiveVendorList = [];
      inActiveVendor = [];
    }
    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
        inActiveVendor.add(Vendor_Model.fromJson(data[i]));
        if(page == 1){
          previewInactiveVendorList.add(Vendor_Model.fromJson(data[i]));
        }
      }
    }
    notifyListeners();
    return data;
  }

  void changeDataWhenStatusChange({required String id,required bool data,required PagingController controller,}){
    print("$id $data ");
    if(data){
      previewInactiveVendorList.removeWhere((element) => element.id == id);
      int indexToRemove = inActiveVendor.indexWhere((element) => element.id == id );
      Vendor_Model removeData = inActiveVendor.removeAt(indexToRemove);
      removeData.status = 1;
      print("Up Pass");
      print("${activeVendorList.length}");
      print("${inActiveVendor.length}");
      previewActiveVendorList = [removeData,...previewActiveVendorList];
      activeVendorList = [removeData,...activeVendorList];
      controller.itemList = inActiveVendor;
      print(controller.itemList);
      notifyListeners();
    }else{
      previewActiveVendorList.removeWhere((element) => element.id == id);
      int indexToRemove = activeVendorList.indexWhere((element) => element.id == id );
      Vendor_Model removeData = activeVendorList.removeAt(indexToRemove);
      removeData.status = 0;
      print(removeData.id);
      print("Under Pass");
      print("${inActiveVendor.length}");
      print("${activeVendorList.toString()}");
      print(controller.itemList);
      previewInactiveVendorList = [removeData,...previewInactiveVendorList];
      controller.itemList = activeVendorList;
      inActiveVendor = [removeData,...inActiveVendor];
      notifyListeners();
    }
  }

  void  setVendorDetails({required Vendor_Model data}){
    vendor_details = data;
    notifyListeners();
  }

  void clearVendor(){
    vendor_details = null;
    notifyListeners();
  }

}