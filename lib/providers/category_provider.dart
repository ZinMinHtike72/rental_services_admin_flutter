import 'package:flutter/foundation.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/models/category_model.dart';
import 'package:rental_services/services/api_services.dart';

class Category_Provider with ChangeNotifier {
  List<Category_Model> categoryList = [];
  bool fetchStatus = false;
  Category_Model? categoryDetails;
  bool addStatus = false;
  Map error = {
    'brandError' : null,
    'nameError' : null,
    'imageError' : null
  };
  
  Future getCategory ({required int pageNum,int? limit}) async{
    fetchStatus = true;
    notifyListeners();
    if(pageNum == 1){
      categoryList = [];
    }
    final resData = await Api_Services.getMethod(path: Constant_Api.category,queryParameter: {
      'limit':limit ?? 10,
      'page':pageNum
    });
    fetchStatus = false;
    notifyListeners();
    final List data = resData['data'];

    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
        categoryList.add(Category_Model(name: data[i]['name'], id: data[i]['_id'], media:  data[i]['media']['media_link'], brand: Brand_Model(name:  data[i]['brand']['name'], id:  data[i]['brand']['id'])));
      }
    }

    return {'newList':data.length ?? 1,'dataList':categoryList};
  }

  void addSingleCategory({required Category_Model data}){
    categoryList.add(data);
    notifyListeners();
  }
  void getCategoryDetails({required String id}){
    categoryDetails = categoryList.where((element) => element.id == id).toList()[0];
    notifyListeners();
  }
  void updateCategory({required Category_Model data}){
    categoryList = categoryList.map((e){
      if(e.id == data.id){
        return data;
      }else{
        return e;
      }
    }).toList();
    getCategoryDetails(id: data.id);
    notifyListeners();
  }

  void deleteCategory({required String id}){
    categoryList.removeWhere((e) =>e.id == id);
    notifyListeners();
  }

  void setError({required Map errorData}){
    error = errorData;
    notifyListeners();
  }

  void setAddStatus({required bool data}){
    addStatus = data;
    notifyListeners();
  }

  void clearCategory(){
    categoryDetails = null;
    notifyListeners();
  }

}