import 'package:flutter/material.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/screens/product/product_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_services/providers/vendor_provider.dart';
class Product_Controller{
  bool status = false;
  PagingController _productPagingController = PagingController(firstPageKey: 1);
  String? productId;
  int limit = 10;
  Map sendData = {
    'product_code':"",
    'name':'',
    'price':'',
    'description':'',
    'category': null,
    'brand' : null,
    'business' :null,
    'duration_date' : {'year':'0','month':'0'},
    'energy_comsumption':'',
    'insurence_date' :{'year':'0','month':'0'},
    'color':[],
    'size':[],
    'extra_device':[],
    'main_thambnail':null,
    'multi_images':[],
    'vendor' : null
  };
  String? oldThumbnail = null;
  Map initialData = {
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

  void setId(String id){
    productId = id;
  }

  PagingController getProductPagingController(){
    return _productPagingController;
  }

  void getProductWithPagination({required BuildContext context,required int pageNum}) async{
    final resData = await context.read<Product_Provider>().getProduct(pageNum: pageNum);
    final int newList = resData['newList'];
    if(newList < limit){
      _productPagingController.appendLastPage(resData['dataList']);
    }else{
      _productPagingController.appendPage(resData['dataList'], pageNum + 1);
    }
    _productPagingController.itemList = resData['dataList'];
  }

  void setOldThumbnails({required String data}){
    oldThumbnail = data;
  }

  void getData({required data,required String type}){
    print(data);
    print(type);
    switch(type){
      case 'product_code':
        sendData['product_code'] = data;
        break;
      case 'name' :
        sendData['name'] = data;
        break;
      case 'price':
        sendData['price'] = data;
        break;
      case 'description':
        sendData['description'] = data;
        break;
      case 'category':
        sendData['category'] = data;
        break;
      case 'brand':
        sendData['brand'] = data;
        break;
      case 'business':
        sendData['business'] = data;
        break;
      case 'energy_comsumption':
        sendData['energy_comsumption'] = data;
        break;
      case 'color':
        sendData['color'] = data;
        break;
      case 'size':
        sendData['size'] = data;
        break;
      case 'extra_device':
        sendData['extra_device'] = data;
        break;
      case 'main_thambnail':
        sendData['main_thambnail'] = data;
        break;
      case 'vendor':
        sendData['vendor'] = data;
        break;
    }
  }

  //Get Rent Duration Date
  void getDuration(Map data){
      sendData['duration_date'] = data;
  }

  //Get InsuranceDuration Date
  void getInsuranceDuration(Map data){
    print(data);
      sendData['insurence_date'] = data;
  }

  //Validate Duration And Calculate Month
  int validateDuration({required Map value}){
    int data =0;
    if(int.parse(value['year'].toString()) != 0){
      data +=  int.parse(value['year'].toString()) *12;
    }
    if(int.parse(value['month'].toString()) != 0){
      data += int.parse(value['month'].toString());
    }
    return data;
  }

  //Validate Multiple input
  List validateMultipleInput({required List value,required String type}){
    if(type == 'text'){
      return value.where((element) => Reuseable_Function.checkIsHave(value: element['text'])).toList();
    }else{
      return value.where((element) => Reuseable_Function.checkIsHave(value :element['image'])).toList();
    }
  }

  void getMultiImage(List image){
    sendData['multi_images'] = image;
    print( sendData['multi_images'][0]['id']);
  }

  //Create Server Send Data
  Map provideData({required BuildContext context}){
    print(sendData);
    final category = Provider.of<Category_Provider>(context, listen: false).categoryDetails;
    final brand =Provider.of<Brand_Provider>(context, listen: false).brandDetails;
    final business=  Provider.of<Business_Provider>(context, listen: false).businessDetails;
    final vendor = Provider.of<Product_Provider>(context, listen: false).vendorDetails;
    Map serverSendData = {...sendData};
    serverSendData['category'] = {'id':category!.id ,'name':category!.name};
    serverSendData['brand'] = {'id':brand!.id,'name':brand!.name};
    serverSendData['business'] = {'id':business!.id,'name':business!.name,'address':business!.address};
    serverSendData['duration_date'] = validateDuration(value: serverSendData['duration_date']);
    serverSendData['insurence_date'] = validateDuration(value: serverSendData['insurence_date']);
    serverSendData['color'] =  validateMultipleInput(value: serverSendData['color'], type: 'text').map((e)=> e['text']).toList();
    serverSendData['size'] =  validateMultipleInput(value: serverSendData['size'], type: 'text').map((e)=> e['text']).toList();
    serverSendData['extra_device'] =  validateMultipleInput(value: serverSendData['extra_device'], type: 'text').map((e)=> e['text']).toList();
    if(productId == null){
      serverSendData['multi_images'] =  validateMultipleInput(value: serverSendData['multi_images'], type: 'image').map((e)=> e['image']).toList();
    }else{
      serverSendData['multi_images'] = validateMultipleInput(value: serverSendData['multi_images'], type: 'image').map((e){
        if(e['id'] == null){
          return e['image'];
        }else{
          if(e['image'].toString()[0] != 'h'){
            return e['image'];
          }else{
            return e['id'];
          }

        }
      }).toList();
    }
    if(vendor != null){
      serverSendData['vendor'] = {'id': vendor.id ,'name':vendor.name};
    }
    print(serverSendData);
    return serverSendData;
  }

  void sendToServer({required BuildContext context}) async{
    context.read<Product_Provider>().setError(data: initialData);
    context.read<Product_Provider>().setAddStatus(data: true);
    final resData;
   if(productId == null){
     resData = await  Api_Services.postMethod(data: provideData(context: context), path: Constant_Api.product);
   }else{
     resData = await Api_Services.putMethod(data: provideData(context: context), path: "${Constant_Api.product}/${productId!}");
   }
    context.read<Product_Provider>().setAddStatus(data: false);
    print(resData);
    if(!resData['error']){
      Navigator.of(context).pop();
      Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Product ${productId == null ? 'Create' : 'Update'} Success", status: 'success');
        if(productId == null){
          context.read<Product_Provider>().addSingleProduct(data: Product_Model.fromJson(resData['data']));
        }else{
          context.read<Product_Provider>().updateSingleProduct(data: Product_Model.fromJson(resData['data']));
        }
    }
  }

  void createProduct ({required BuildContext context}){
    ///Validate Send Data
    bool nameResult = Reuseable_Function.checkIsHave(value: sendData['name']);
    bool codeResult = Reuseable_Function.checkIsHave(value: sendData['product_code']);
    bool priceResult = Reuseable_Function.checkIsHave(value: sendData['price']);
    bool descResult = Reuseable_Function.checkIsHave(value: sendData['description']);
    bool energyResult = Reuseable_Function.checkIsHave(value: sendData['energy_comsumption']);
    bool durationResult =  validateDuration(value: sendData['duration_date']) == 0 ? false :true;
    bool insuranceResult = validateDuration(value: sendData['insurence_date']) == 0 ? false : true;
    bool colorResult = validateMultipleInput(value: sendData['color'],type: "text").length == 0 ? false : true;
    bool sizeResult = validateMultipleInput(value: sendData['size'], type: 'text').length == 0 ?  false : true;
    bool extraResult = validateMultipleInput(value: sendData['extra_device'], type: 'text').length ==0? false : true;
    bool categoryResult = Reuseable_Function.checkIsHave(value: sendData['category'] ?? '');
    bool brandResult = Reuseable_Function.checkIsHave(value: sendData['brand'] ?? '');
    bool businessResult = Reuseable_Function.checkIsHave(value: sendData['business'] ?? '');
    bool thumbnailResult = productId == null ? Reuseable_Function.checkIsHave(value: sendData['main_thambnail']) : true;
    bool multiImageResult = productId == null ? validateMultipleInput(value: sendData['multi_images'], type: 'image').length == 0 ? false :true : true;
    // print();
    if(!nameResult || !codeResult || !priceResult || !energyResult || !insuranceResult || !colorResult || !sizeResult || !extraResult || !categoryResult || !brandResult || !businessResult || !thumbnailResult || !multiImageResult){
        Map error= {};
        error['name'] = !nameResult ? "Need To Fill The Product Name !" : null;
        error['product_code'] = !codeResult ? "Need To Fill The Code !" :null;
        error['price'] = !priceResult ? "Need To Fill The Price !" : null;
        error['description'] = !descResult ? "Need To Fill The Description !" :null;
        error['energy_comsumption'] = !energyResult ? 'Need To Fill The Energy Consumption !':null;
        error['duration_date'] = !durationResult ? 'Need To Fill The Duration ! ' : null;
        error['insurence_date'] = !insuranceResult ? 'Need To Fill The Insurance Duration !' : null;
        error['color'] = !colorResult ? 'Need To Fill The Color !' : null;
        error['size'] = !sizeResult ? 'Need To Fill The Size !' : null;
        error['extra_device'] = !extraResult ? 'Need To Fill The Extra !' : null ;
        error['category'] = !categoryResult ? 'Need To Select Category !' : null ;
        error['brand'] = !brandResult ? 'Need To Select The Brand !' : null ;
        error['business'] = !businessResult ? ' Need To Select The Business !' : null;
        error['main_thambnail'] = !thumbnailResult ? 'Need To Select The Image !':null;
        error['multi_images'] = !multiImageResult ? 'Need To Select The Image !':null;
        Alert_Dialog.Cus_Snackbar(context: context, label: "Somethings Wrong Try Again !",bgColor: Colors.red);
        context.read<Product_Provider>().setError(data: error);
    }else{
      sendToServer(context: context);
    }
  }

  //Show Delete Dialog
  Future<void> deleteProduct({required BuildContext context,required String id}) async{
    final resData= await Api_Services.deleteMethod(path:"${Constant_Api.product}/${id}");
    if(!resData['error']){
      Navigator.of(context).pop();
      context.read<Product_Provider>().deleteProduct(id: id);
    }
  }
  void showDialog ({required BuildContext context,required String name,required String id}) {
    Alert_Dialog.Confirm_Dialog(context: context,title: "Are You Sure To Delete ${name} ?",actionText:"Delete",actionFun:(){return deleteProduct(context: context,id:id );},buttonColor: Colors.red ,status: 'Product');
  }

  void clearData({required BuildContext context}){
    Provider.of<Vendor_Provider>(context,listen: false).clearVendor();
    Provider.of<Category_Provider>(context,listen: false).clearCategory();
    Provider.of<Brand_Provider>(context,listen: false).clearBrand();
    Provider.of<Business_Provider>(context,listen: false).clearBusiness();
  }

}