import 'package:flutter/foundation.dart';
import 'package:rental_services/models/rent_model.dart';
import 'package:rental_services/services/api_services.dart';

class Rent_Provider with ChangeNotifier{
  List<Rent_Model> rentList = [];
  late Rent_Model rentDetails ;

  Future getRentList({required int pageNum,int? limit}) async{
    final resData = await Api_Services.getMethod(path:Constant_Api.rentLists,queryParameter: {
      'page':pageNum,
      'limit': limit ?? 10
    });
    final List data = resData['data'];
    if(pageNum == 1){
      rentList = [];
    }
    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
        rentList.add(Rent_Model.fromJson(data[i]));
      }
    }
    return {'newList':data.length ?? 1,'dataList': rentList};
  }

  void setRentDetails({required Rent_Model data}){
    rentDetails = data;
    notifyListeners();
  }
}