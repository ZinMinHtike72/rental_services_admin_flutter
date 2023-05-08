import 'package:flutter/material.dart';
import 'package:rental_services/components/cus_input.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:rental_services/components/drop_down_select.dart';
import 'package:rental_services/components/cus_image_picker.dart';
import 'package:rental_services/components/multi_input.dart';
import 'package:rental_services/screens/product/components/Select_Month.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'dart:convert';
import 'package:rental_services/components/multi_select_image.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/controller/product_controller.dart';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/components/select_box.dart';
class Product_Add extends StatefulWidget {
  Product_Model? data;
  Product_Add({Key? key,Product_Model? this.data}) : super(key: key);
  @override
  State<Product_Add> createState() => _Product_AddState();
}

class _Product_AddState extends State<Product_Add> {
  var productController = Product_Controller();
  @override
  void initState(){
    if(widget.data == null){
      productController.clearData(context: context);
    }
    super.initState();
    if(widget.data != null){
      productController.getData(data:widget.data!.name,type:'name');
      productController.getData(data:widget.data!.productCode,type:'product_code');
      productController.getData(data:widget.data!.price,type:'price');
      productController.getData(data:widget.data!.description,type:'description');
      productController.getData(data:widget.data!.energyConsumption,type:'energy_comsumption');
      productController.getDuration( Reuseable_Function.convertMonthsToYearsAndMonths(widget.data!.durationDate));
      productController.getInsuranceDuration(Reuseable_Function.convertMonthsToYearsAndMonths(widget.data!.insuranceDate));
      productController.getData(data:widget.data!.color.map((e) => {'text':e}).toList(),type:'color');
      productController.getData(data:widget.data!.size.map((e) => {'text':e}).toList(),type:'size');
      productController.getData(data:widget.data!.extraDevice.map((e) => {'text':e}).toList(),type:'extra_device');
      productController.getMultiImage(widget.data!.multiImages.map((e) => {'image':e['media_link'],'id':e['id']}).toList());
      if(widget.data?.vendor != null){
        productController.getData(data: widget.data!.vendor!.id,type:'vendor');
      }
      productController.getData(data:widget.data!.category.id,type:'category');
      productController.getData(data:widget.data!.brand.id,type:'brand');
      productController.getData(data:widget.data!.business.id,type:'business');
      productController.setOldThumbnails(data: widget.data!.mainThumbnail.media_link);
      productController.setId(widget.data!.id);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await Future.wait([
        context.read<Brand_Provider>().getBrandList(pageNum: 1,limit: 100000),
        context.read<Category_Provider>().getCategory(pageNum: 1,limit: 100000),
        context.read<Business_Provider>().getBusinessList(pageNum: 1,limit: 100000),
        context.read<Product_Provider>().getVendorList()
      ]);

      if(widget.data != null){
        context.read<Brand_Provider>().getBrandDetails(id:widget.data!.brand.id );
        context.read<Category_Provider>().getCategoryDetails(id: widget.data!.category.id );
        context.read<Business_Provider>().getBusinessDetails(id: widget.data!.business.id);
        if(widget.data!.vendor != null){
          context.read<Product_Provider>().getVendorDetails(id: widget.data!.vendor!.id);
        }
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    List brandList =  Reuseable_Function.Drop_Down_Data(value: context.watch<Brand_Provider>().brandList);
    List categoryList = Reuseable_Function.Drop_Down_Data(value:  context.watch<Category_Provider>().categoryList);
    List businessList = Reuseable_Function.Drop_Down_Data(value: context.watch<Business_Provider>().businessList);
    List vendorList = Reuseable_Function.Drop_Down_Data(value: context.watch<Product_Provider>().vendorList);
    return Consumer<Product_Provider>(
        builder: (context,data,child){
          return Scaffold(
            appBar: AppBar(
              title: Text("Add Product"),
            ),
            body:  Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Cus_Input(label: "Product Name", onChange: (value){
                      productController.getData(data:value,type:'name');
                    },value:  productController.sendData['name'],errorText: data.error['name'],),
                    SizedBox(
                      height: 10,
                    ),
                    Cus_Input(label: "Code", onChange: (value){
                      productController.getData(data:value,type:'product_code');
                    },value:  productController.sendData['product_code'],errorText: data.error['product_code'],),
                    SizedBox(
                      height: 10,
                    ),
                    Cus_Input(label: "Price", onChange: (value){
                      productController.getData(data:value,type:'price');
                    },value: productController.sendData['price'],keyboardType: 'number',errorText: data.error['price'],),
                    SizedBox(
                      height: 10,
                    ),
                    Cus_Input(label: "Description",maxLine: 5, onChange: (value){
                      productController.getData(data:value,type:'description');
                    },value: productController.sendData['description'],errorText: data.error['description'],),
                    SizedBox(
                      height: 10,
                    ),
                    Cus_Input(label: "Energy Consumption", onChange: (value){
                      productController.getData(data:value,type:'energy_comsumption');
                    },value:  productController.sendData['energy_comsumption'],errorText: data.error['energy_comsumption'],),
                    SizedBox(
                      height: 10,
                    ),
                    Select_Month(onChange: productController.getDuration,label: "Select Duration",value: productController.sendData['duration_date'],errorText: data.error['duration_date'],),
                    SizedBox(
                      height: 10,
                    ),
                    Select_Month(onChange: productController.getInsuranceDuration,label: "Select Insurance Duration",value: productController.sendData['insurence_date'],errorText: data.error['insurence_date'],),
                    SizedBox(
                      height: 10,
                    ),
                    Multi_Input(label: "Colors", onChange: (value){
                      productController.getData(data:value,type:'color');
                    },value:productController.sendData['color'] ,errorText: data.error['color'],),
                    SizedBox(
                      height: 10,
                    ),
                    Multi_Input(label: "Sizes", onChange: (value){
                      productController.getData(data:value,type:'size');
                    },value: productController.sendData['size'],errorText: data.error['size'],),
                    SizedBox(
                      height: 10,
                    ),
                    Multi_Input(label: "Extras", onChange: (value){
                      productController.getData(data:value,type:'extra_device');
                    },value: productController.sendData['extra_device'],errorText: data.error['extra_device'],),
                    SizedBox(
                      height: 10,
                    ),
                    Select_Box(label: "Select Vendor",value:{'id' :context.watch<Product_Provider>().vendorDetails?.id,'name':context.watch<Product_Provider>().vendorDetails?.name} ,fetchStatus: context.watch<Product_Provider>().vendorStatus,list: vendorList,onChanged: (value){
                      productController.getData(data:value,type:'vendor');
                      context.read<Product_Provider>().getVendorDetails(id: value);
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Select_Box(label: "Select Category",value:{'id' :context.watch<Category_Provider>().categoryDetails?.id,'name':context.watch<Category_Provider>().categoryDetails?.name} ,fetchStatus: context.watch<Category_Provider>().fetchStatus,list: categoryList,onChanged: (value){
                      productController.getData(data:value,type:'category');
                      context.read<Category_Provider>().getCategoryDetails(id: value);
                    },errorText: data.error['category']),
                    SizedBox(
                      height: 10,
                    ),
                    Select_Box(label:  "Select Brand",value:{'id' :context.watch<Brand_Provider>().brandDetails?.id,'name':context.watch<Brand_Provider>().brandDetails?.name} ,fetchStatus: context.watch<Brand_Provider>().fetchStatus,list: brandList,onChanged: (value){
                      productController.getData(data:value,type:'brand');
                      context.read<Brand_Provider>().getBrandDetails(id: value);
                    },errorText: data.error['brand'],),
                    SizedBox(
                      height: 10,
                    ),
                    Select_Box(label:  "Select Business",value:{'id' :context.watch<Business_Provider>().businessDetails?.id,'name':context.watch<Business_Provider>().businessDetails?.name} ,fetchStatus: context.watch<Business_Provider>().fetchStatus,list: businessList,onChanged: (value){
                      productController.getData(data:value,type:'business');
                      context.read<Business_Provider>().getBusinessDetails(id: value);
                    },errorText: data.error['business']),
                    SizedBox(
                      height: 10,
                    ),
                    Cus_Image_Picker(setData: (value){
                      productController.getData(data:value,type:'main_thambnail');
                    }, label: "Thumbnail Image",errorText: data.error['main_thambnail'],oldImage: productController.oldThumbnail,),
                    SizedBox(
                      height: 10,
                    ),
                    Multi_Select_Image(label: "More Image For Product",onChange: productController.getMultiImage,errorText: data.error['multi_images'],value: productController.sendData['multi_images'],),
                    SizedBox(
                      height: 10,
                    ),
                    Loading_Button(label: "${widget.data == null ? 'Create' :'Update' } Product", status: data.addStatus, loadingStatus: "${widget.data == null ? 'Creating' :'Updating'}", onPressed: (){productController.createProduct(context:context);}),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}
