import 'package:flutter/foundation.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/brand_model.dart';

class Business_Provider with ChangeNotifier{
  List<Business_Model> businessList = [];
  bool fetchStatus = false;
  bool addStatus = false;
  Business_Model? businessDetails;
  Map error = {
    'name' : null,
    'address' : null,
    'media' : null
  };
  Future getBusinessList({required int pageNum,int? limit}) async{
    fetchStatus = true;
    notifyListeners();
    final resData = await Api_Services.getMethod(path: Constant_Api.business,queryParameter: {
      'limit' : limit ?? 10,
      'page':pageNum
    });
    fetchStatus = false;
    if(pageNum == 1){
      print("Pass");
      businessList = [];
    }
    notifyListeners();
    final data = resData['data'];
    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
        businessList.add(Business_Model(id: data[i]['_id'], name: data[i]['name'], address: data[i]['address'], media: Media(id: data[i]['media']['id'], media_link: data[i]['media']['media_link'])));
      }
    }
    return {'newList': data.length ?? 1,'dataList':businessList};
  }

  void getBusinessDetails({required String id}){
    businessDetails = businessList.where((element) => element.id == id).toList()[0];
    notifyListeners();
  }

  void addSingleBusiness({required Business_Model data}){
    businessList.add(data);
    notifyListeners();
  }

  void updateBusiness({required Business_Model data}){
    businessList = businessList.map((e) {
      if(e.id == data.id){
        return data;
      }else{
        return e;
      }
    }).toList();
    getBusinessDetails(id: data.id);
    notifyListeners();
  }

  void deleteBusiness({required String id}){
    businessList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
  void setAddStatus({required bool data}){
    addStatus = data;
    notifyListeners();
  }

  void setError({required Map errorData}){
    error = errorData;
    notifyListeners();
  }

  void clearBusiness(){
    businessDetails = null;
    notifyListeners();
  }
}
