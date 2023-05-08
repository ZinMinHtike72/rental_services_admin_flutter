import 'package:flutter/material.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/category_model.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Category_Controller{
  String? categoryName =null;
  String? categoryMedia = null;
  String? brandData  = null;
  String? oldImage =  null;
  bool status = false;
  String? type;
  String? id;
  int limit = 10;
  PagingController _categoryPagingController = PagingController(firstPageKey: 1);
  Category_Controller({String? this.type});


  PagingController getPagingController(){
    return _categoryPagingController;
  }

  void setCategoryName(String data){
    categoryName = data;
  }

  void setSetCategoryMedia(String data){
    categoryMedia= data;
  }

  void setBrandValue({required BuildContext context,required String id}){
    brandData = id;
    context.read<Brand_Provider>().getBrandDetails(id: id!);
  }

  void setOldImage({required String data}){
    oldImage = data;
  }

  void setId({required String data}){
    id = data;
  }

  void getCategoryWithPagination({required BuildContext context,required int data}) async{
    final resData = await context.read<Category_Provider>().getCategory(pageNum: data,limit: limit);
    final int newList =  resData['newList'];
    if(newList < limit){
      _categoryPagingController.appendLastPage(resData['dataList']);
    }else{
      _categoryPagingController.appendPage(resData['dataList'], data +1);
    }
    _categoryPagingController.itemList = resData['dataList'];
  }

  void createCategory({required BuildContext context}) async{
    final nameResult = Reuseable_Function.checkIsHave(value: categoryName ?? '');
    final imageResult = type == null ?  Reuseable_Function.checkIsHave(value: categoryMedia ?? ''):true;
    final brandResult = Reuseable_Function.checkIsHave(value: brandData ?? '');
    if(!nameResult || !imageResult){
      Map errorData = {
        'nameError' : !nameResult ? 'Need To Fill The Brand Name !' : null,
        'imageError' : !imageResult ? 'Need To Select The image !' : null,
        'brandError' :!brandResult ? 'Need To Select The Brand !' :null
      };
      context.read<Category_Provider>().setError(errorData: errorData);
    }else{
      Map errorData =  {
        'nameError' : null,
        'imageError' :  null,
        'brandError' :null,
      };
      context.read<Category_Provider>().setError(errorData: errorData);
      Brand_Model bData = Provider.of<Brand_Provider>(context,listen: false).brandDetails!;

      try{
        final sendData = {
          'name' : categoryName,
          'media':categoryMedia,
          'brand':{
            "id" : bData.id,
            "name":bData.name,
          }
        };
        context.read<Category_Provider>().setAddStatus(data: true);
        final resData;
        if(type == null){
          resData = await Api_Services.postMethod(data: sendData, path: Constant_Api.category);
        }else{
          resData = await Api_Services.putMethod(data: sendData, path: "${Constant_Api.category}/${id}");
        }
        context.read<Category_Provider>().setAddStatus(data: false);
        if(!resData['error']){
          Navigator.of(context).pop();
          final data = resData['data'];
          if(type == null){
            context.read<Category_Provider>().addSingleCategory(data: Category_Model(name: data['name'], id: data['_id'], media: data['media']['media_link'], brand: Brand_Model(name: data['name'], id: data['brand']['id'])));
          }else{
            context.read<Category_Provider>().updateCategory(data: Category_Model(name: data['name'], id: data['_id'], media: data['media']['media_link'], brand: Brand_Model(name: data['name'], id: data['brand']['id'])));
          }
          Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Category ${type == null ? 'Add' : 'Update'} Success", status: "success");
        }
      }catch(error){
        context.read<Category_Provider>().setAddStatus(data: false);
        Alert_Dialog.Cus_Snackbar(context: context, label: "SomeThing Wrong! Try Again!",bgColor: Colors.red);
      }
    }
  }

  Future<void> deleteCategory({required BuildContext context,required String id}) async{
    final resData = await Api_Services.deleteMethod(path: "${Constant_Api.category}/${id}");
    if(!resData['error']){
      Navigator.of(context).pop();
      context.read<Category_Provider>().deleteCategory(id: id);
    }
  }

  void showDialog ({required BuildContext context,required String name, required String id}) {
    Alert_Dialog.Confirm_Dialog(context: context,title: "Are You Sure To Delete ${name} ?",actionText:"Delete",actionFun:(){return deleteCategory(context: context,id: id);},buttonColor: Colors.red ,status: 'Category');
  }
}