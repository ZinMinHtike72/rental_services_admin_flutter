import 'package:flutter/material.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/screens/Brand/brand_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Brand_Controller{
  String? brandName =null;
  String? brandMedia = null;
  int limit =10;
  String? oldImage = null;
  String? type;
  String? id;
  Brand_Controller({String? this.type});
  final PagingController _brandPagingController = PagingController(firstPageKey: 1);

  //Add & Update Brand
  void getBrandName(String data){
    brandName = data;
  }

  PagingController getBrandPaging() {
   return _brandPagingController;
  }

  void getBrandMedia(String data){
    brandMedia = data;
  }
  void setOldImage(String data){
    oldImage = data;
  }
  void setId(String data){
    id = data;
  }

  void getBrandWithPagination({required BuildContext context,required int pageKey}) async{
    final resData = await context.read<Brand_Provider>().getBrandList(pageNum: pageKey);
    final int newList = resData['newList'];
    if( newList< limit){
      _brandPagingController.appendLastPage(resData['dataList']);
    }else{
      _brandPagingController.appendPage(resData['dataList'], pageKey + 1);
    }
    _brandPagingController.itemList = resData['dataList'];
  }

  void createBrand({required BuildContext context}) async{
    final nameResult = Reuseable_Function.checkIsHave(value: brandName ?? '');
    final imageResult = type != null ? true : Reuseable_Function.checkIsHave(value: brandMedia ?? '');
    if(!nameResult || !imageResult){
      Map errorData = {
          'nameError' : !nameResult ? 'Need To Fill The Brand Name !' : null,
          'imageError' : !imageResult ? 'Need To Select The image !' : null,
      };
      context.read<Brand_Provider>().setBrandError(data: errorData);
    }else{
      Map errorData = {
        'nameError' : null,
        'imageError' : null,
      };
      context.read<Brand_Provider>().setBrandError(data: errorData);
      try{
        final sendData = {
          'name' : brandName,
          'media':brandMedia
        };
        context.read<Brand_Provider>().setAddStatus(data: true);
        final resData;
        if(type == null){
          resData = await Api_Services.postMethod(data: sendData, path: Constant_Api.brandsApi);
        }else{
          resData = await Api_Services.putMethod(data: sendData, path: "${Constant_Api.brandsApi}/$id");
        }
        context.read<Brand_Provider>().setAddStatus(data: false);
        if(!resData['error']){
          Navigator.of(context).pop();
          if(type == null){
            context.read<Brand_Provider>().addSingleBrand(data:Brand_Model(name: resData['data']['name'], id: resData['data']['_id'], media: Media(id: resData['data']['media']['id'], media_link:resData['data']['media']['media_link'])));
          }else{
            context.read<Brand_Provider>().updateBrand(data:Brand_Model(name: resData['data']['name'], id: resData['data']['_id'], media: Media(id: resData['data']['media']['id'], media_link:resData['data']['media']['media_link'])));
          }
          Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Brand ${type == null ? 'Create' : 'Update' } Success", status: 'success');
        }
      }catch(error){
        context.read<Brand_Provider>().setAddStatus(data: false);
        Alert_Dialog.Cus_Snackbar(context: context, label: 'Somethings Wrong . Try Again !',bgColor: Colors.red);
      }
    }
  }
  Future<void> deleteBrand({required BuildContext context, required String id}) async {
    final resData = await Api_Services.deleteMethod(path: "${Constant_Api.brandsApi}/$id");
    if (!resData['error']) {
      Navigator.of(context).pop();
      final brandProvider = Provider.of<Brand_Provider>(context, listen: false);
      brandProvider.deleteBrand(id: id);
    }
  }
  void showDialog ({required BuildContext context,required String name,required String id}) {
    Alert_Dialog.Confirm_Dialog(context: context,title: "Are You Sure To Delete ${name} ?",actionText:"Delete",actionFun:(){return deleteBrand(context: context,id:id );},buttonColor: Colors.red,status: 'Brand');
  }

}