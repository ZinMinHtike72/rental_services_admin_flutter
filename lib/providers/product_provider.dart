import 'package:flutter/foundation.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/product_model.dart';
import 'dart:convert';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/models/product_vendor_model.dart';

class Product_Provider with ChangeNotifier {
  List<Product_Model> productList = [];
  List<Product_Vendor_Model> vendorList = [];
  bool vendorStatus = false;
  bool fetchStatus = false;
  Product_Vendor_Model? vendorDetails;
  late Product_Model productDetails;

  //Add Variable
  bool addStatus = false;
  late Map error =  {
    'product_code':null,
    'name':null,
    'price':null,
    'description':null,
    'category': null,
    'brand' : null,
    'business' :null,
    'duration_date' : null,
    'energy_comsumption':null,
    'insurence_date' :null,
    'color':null,
    'size':null,
    'extra_device':null,
    'main_thambnail':null,
    'multi_images':null,
  };

  Future getProduct ({required int pageNum,int? limit}) async{
    fetchStatus = true;
    notifyListeners();
    final resData = await Api_Services.getMethod(path: Constant_Api.product,queryParameter: {
      'page':pageNum,
      'limit':limit
    });
    fetchStatus = false;
    notifyListeners();
    if(pageNum == 1){
      productList = [];
    }
    final List data = resData['data'];
    print(data);
    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
        productList.add(Product_Model.fromJson(data[i]));
      }
    }
    return {'newList': data.length ,'dataList':productList};
  }

  void addSingleProduct({required Product_Model data}){
    productList.add(data);
    notifyListeners();
  }

  void updateSingleProduct({required Product_Model data}){
    productList = productList.map((e){
      if(e.id == data.id){
        return data;
      }else{
        return e;
      }
    }).toList();
    setProductDetails(id: data.id);
    notifyListeners();
  }

  void deleteProduct({required String id}){
    productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void setProductDetails({required String id}){
    productDetails = productList.where((element) => element.id == id).toList()[0];
    notifyListeners();
  }

  void setAddStatus({required bool data}){
    addStatus = data;
    notifyListeners();
  }

  void setError({required Map data}){
    error = data;
    notifyListeners();
  }

  Future getVendorList() async{
    vendorStatus = true;
    notifyListeners();
    final resData = await Api_Services.getMethod(path: Constant_Api.productVendor);
    final data = resData['data'];
    vendorStatus = false;
    vendorList = [];
    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
        vendorList.add(Product_Vendor_Model(id: data[i]["_id"],name: data[i]['name']));
      }
    }
    notifyListeners();
  }

  void getVendorDetails({required String id}){
    print("Pass");
    vendorDetails = vendorList.where((element) => element.id == id).toList()[0];
    notifyListeners();
  }



}