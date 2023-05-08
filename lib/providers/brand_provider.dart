import 'package:flutter/foundation.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/brand_model.dart';

class Brand_Provider with ChangeNotifier {
  List<Brand_Model> brandList = [];
  bool fetchStatus = false;
  bool addStatus = false;
  Brand_Model? brandDetails;

  Map error = {
    'nameError' : null,
    'imageError' : null
  };
  
  Future getBrandList({required int pageNum,int? limit}) async{
    fetchStatus = true;
    notifyListeners();
    if(pageNum == 1){
      brandList = [];
    }
    final resData = await Api_Services.getMethod(path: Constant_Api.brandsApi,queryParameter: {
      'page':pageNum,
      'limit':limit ?? 10
    });
    fetchStatus = false;
    notifyListeners();
    final List data = resData['data'] ?? [];
    for(var i = 0 ; i < data.length; i++){
      brandList.add(Brand_Model(name: data[i]['name'], id: data[i]['_id'], media: Media(id:data[i]['media']['id'] , media_link: data[i]['media']['media_link'])));
    }
    // brandList.add(Brand_Model(name: name, id: id, media: media));
   return  {'newList': data.length ?? 1,'dataList':brandList};;
  }

  void addSingleBrand({required Brand_Model data}){
    brandList.add(data);
    notifyListeners();
  }

  void getBrandDetails({required String id}) {
    brandDetails =brandList.where((element) => element.id == id).toList()[0];
    notifyListeners();
  }

  void setBrandDetails({required Brand_Model data}){
    brandDetails = data;
    notifyListeners();
  }

  void updateBrand({required Brand_Model data}){
   brandList = brandList.map((e) {
      if(e.id == data.id){
        return data;
      }else{
        return e;
      }
    }).toList();
   getBrandDetails(id: data.id);
   notifyListeners();
  }

  void deleteBrand({required String id}){
      brandList.removeWhere((e) =>e.id == id);
      print("Pass");
      notifyListeners();
  }

  void setAddStatus({required bool data}){
    addStatus = data;
    notifyListeners();
  }

  void setBrandError({required Map data}){
    error = data;
    notifyListeners();
  }

  void clearBrand(){
    brandDetails = null;
    notifyListeners();
  }
  
}
