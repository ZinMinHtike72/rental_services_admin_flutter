import 'package:flutter/foundation.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/models/category_model.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/models/rent_model.dart';

class Search_Provider with ChangeNotifier{
  List data = [];
  bool fetchStatus = false;
  String? type;

  void searchData({String? key}) async{
    data = [];
    late String path;
    late Map queryParameter;
    fetchStatus = true;
    notifyListeners();
    switch(type){
      case 'brand':
        path = Constant_Api.brandsApi;
        queryParameter = {
          'brand_name' : key
        };
        break;
      case 'category':
        path = Constant_Api.category;
        queryParameter = {
          'category_name' :key
        };
        break;
      case 'business':
        path = Constant_Api.business;
        queryParameter = {
          'business_name' :key
        };
        break;
      case 'product':
        path = Constant_Api.product;
        queryParameter = {
          'product_name' :key
        };
        break;
      case 'activeVendor':
        path = Constant_Api.activeVendorList;
        queryParameter = {
          'activeVendor_name' :key
        };
        break;
      case 'inactiveVendor':
        path = Constant_Api.inActiveVendorList;
        queryParameter = {
          'inactiveVendor_name' :key
        };
        break;
      case 'rent':
        path = Constant_Api.rentLists;
        queryParameter = {
          'rentUser_Name' : key
        };
        break;
    }
    final serverResData =await Api_Services.getMethod(path: path,queryParameter: queryParameter);
    fetchStatus = false;
    final resData = serverResData['data'];
    for(var i = 0 ; i < resData.length; i++){
      switch(type){
        case 'brand':
            data.add(Brand_Model(name: resData[i]['name'], id: resData[i]['_id'], media: Media(id:resData[i]['media']['id'] , media_link: resData[i]['media']['media_link'])));
          break;
        case 'category':
            data.add(Category_Model(name: resData[i]['name'], id: resData[i]['_id'], media: resData[i]['media']['media_link'], brand: Brand_Model(name: resData[i]['brand']['name'], id: resData[i]['brand']['id'])));
          break;
        case 'business':
          data.add(Business_Model(id:resData[i]['_id'] , name: resData[i]['name'], address: resData[i]['address'], media: Media(id: resData[i]['media']['id'], media_link: resData[i]['media']['media_link'])));
          break;
        case 'product':
          data.add(Product_Model.fromJson(resData[i]));
          break;
        case 'activeVendor':
          data.add(Vendor_Model.fromJson(resData[i]));
          break;
        case 'inactiveVendor':
          data.add(Vendor_Model.fromJson(resData[i]));
          break;
        case 'rent':
          data.add(Rent_Model.fromJson(resData[i]));
          break;
      }
    }

    notifyListeners();
  }
  void setType({required String searchType}){
    type = searchType;
  }
  void clearData(){
    data = [];
  }
}