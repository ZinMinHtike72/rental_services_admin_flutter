import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:provider/provider.dart';
class Business_Controller{
  String businessName = "";
  String address = '';
  String businessMedia = "";
  String? oldImage;
  String? type;
  String? id;
  int limit = 10;
  Business_Controller({String? this.type});
  PagingController _businessPagingController = PagingController(firstPageKey: 1);

  void setName(String data){
    businessName = data;
  }

  PagingController getBusinessPagingController(){
    return _businessPagingController;
  }

  void setAddress(String data){
    address = data;
  }

  void setMedia(String data){
    businessMedia = data;
  }

  void setOldImage(String data){
    oldImage =data;
  }

  void setId(String data){
    id = data;
  }

  void getBusinessWithPagination({required BuildContext context,required int pageNum}) async{
    final resData =  await context.read<Business_Provider>().getBusinessList(pageNum: pageNum,limit: limit);
    final int newList = resData['newList'];
    if(newList < limit){
      _businessPagingController.appendLastPage(resData['dataList']);
    }else{
      _businessPagingController.appendPage(resData['dataList'], pageNum + 1);
    }
    _businessPagingController.itemList = resData['dataList'];
  }

  void createBusiness({required BuildContext context}) async{
    final nameResult = Reuseable_Function.checkIsHave(value: businessName);
    final addressResult = Reuseable_Function.checkIsHave(value:address );
    final mediaResult = type == null ?  Reuseable_Function.checkIsHave(value: businessMedia) : true;
    if(!nameResult || !addressResult || !mediaResult){
      Map errorData = {
        'name' : nameResult ? null : ' Need To Fill The Name !',
        'address' : addressResult ? null : 'Need To Fill The Result !',
        'media' :mediaResult ? null : 'Need To Select The Image !'
      };
      context.read<Business_Provider>().setError(errorData: errorData);
    }else{
      Map errorData = {
        'name' : null,
        'address' : null,
        'media' :null
      };
      context.read<Business_Provider>().setError(errorData: errorData);
      final sendData = {
        'name' : businessName,
        'address':address,
        'media':businessMedia
      };
      context.read<Business_Provider>().setAddStatus(data: true);
      final resData;
      if(type == null){
        resData = await Api_Services.postMethod(data: sendData, path: Constant_Api.business);
      }else{
        resData = await Api_Services.putMethod(data: sendData, path: "${Constant_Api.business}/${id}");
      }
      context.read<Business_Provider>().setAddStatus(data: false);

      if(!resData['error']){
        final serverData = resData['data'];
        final data = Business_Model(id: serverData['_id'] , name: serverData['name'], address: serverData['address'], media: Media(id: serverData['media']['id'], media_link: serverData['media']['media_link']));
        if(type == null){
          context.read<Business_Provider>().addSingleBusiness(data: data);
        }else{
          context.read<Business_Provider>().updateBusiness(data: data);
        }
        Navigator.of(context).pop();
        Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Business ${type == null ? 'Add' : 'Update'} Success !", status: 'success');
      }
    }
  }
  Future<void> deleteBrand({required BuildContext context,required String id}) async{
    print("${Constant_Api.business}/${id}");
    final resData = await Api_Services.deleteMethod(path: "${Constant_Api.business}/${id}");
    if(!resData['error']){
      Navigator.of(context).pop();
      context.read<Business_Provider>().deleteBusiness(id:id!);
    }
  }
  void showDialog ({required BuildContext context,required String name,required String id}) {
    Alert_Dialog.Confirm_Dialog(context: context,title: "Are You Sure To Delete ${name} ?",actionText:"Delete",actionFun:(){return deleteBrand(context: context,id: id);},buttonColor: Colors.red ,status: 'Business');
  }

}