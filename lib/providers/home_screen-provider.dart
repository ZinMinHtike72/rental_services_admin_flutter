import 'package:flutter/foundation.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/count_model.dart';


class Home_Screen_Provider with ChangeNotifier{
  List<Count_Model> dataList = [];
  Future getList() async{
    final resData = await Api_Services.getMethod(path:Constant_Api.count);
    final data = resData['data'];
    dataList = [];
    if(!resData['error']){
      for(var i = 0 ; i < data.length; i++){
          dataList.add(Count_Model.fromJson(data[i]));
      }
    }
    notifyListeners();
    return dataList;
  }

}