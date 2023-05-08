import 'package:flutter/material.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:rental_services/components/cus_input.dart';
import 'package:rental_services/components/cus_image_picker.dart';
import 'package:rental_services/components/drop_down_select.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/models/category_model.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:rental_services/controller/category_controller.dart';
import 'package:rental_services/components/select_box.dart';
import 'package:rental_services/providers/brand_provider.dart';

class Category_Add extends StatefulWidget {
  Category_Model? data;
  Category_Add({Key? key,Category_Model? this.data}) : super(key: key);
  @override
  State<Category_Add> createState() => _Category_AddState();
}
class _Category_AddState extends State<Category_Add> {
  var categoryController;

  @override
  void initState(){
    if(widget.data == null){
      context.read<Brand_Provider>().clearBrand();
    }
    super.initState();
    categoryController = Category_Controller(type: widget.data != null ? 'update' : null);
    if(widget.data != null){
      categoryController.setCategoryName(widget.data!.name);
      categoryController.setOldImage(data:widget.data!.media);
      categoryController.setId(data:widget.data!.id);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await context.read<Brand_Provider>().getBrandList(pageNum: 1,limit: 100000);
     if(widget.data != null){
       categoryController.setBrandValue(context:context,id: widget.data!.brand!.id);
     }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<Category_Provider>(
        builder: (context,data,child){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("${widget.data == null ? "Add" :  "Update"}  Category"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child: Column(
                children: [
                  Cus_Input(label: "Category Name",onChange: (data){
                    categoryController.setCategoryName(data);
                  },errorText:data.error['nameError'],value: categoryController.categoryName,),
                  SizedBox(
                    height: 8,
                  ),
                  Select_Box(label: "Select Brand",list: context.watch<Brand_Provider>().brandList.map((e){return {"id":e.id,"name":e.name};}).toList(), onChanged: (data){categoryController.setBrandValue(context:context,id:data);},errorText: data.error['brandError'],value:{'id':context.watch<Brand_Provider>().brandDetails?.id,'name':context.watch<Brand_Provider>().brandDetails?.name} ,fetchStatus: context.watch<Brand_Provider>().fetchStatus ,),
                  // Drop_Down_Select(label: "Select Brand",errorText: data.error['brandError'],onChanged:(data){categoryController.setBrandValue(context:context,id:data);} ,list: context.watch<Brand_Provider>().brandList.map((e){return {"id":e.id,"name":e.name};}).toList(),dropdownValue: categoryController.brandData ,fetchStatus: context.watch<Brand_Provider>().fetchStatus,),
                  SizedBox(
                    height: 8,
                  ),
                  Cus_Image_Picker(setData: (data){
                    categoryController.setSetCategoryMedia(data);
                  },label: "Category Image",errorText: data.error['imageError'],oldImage: categoryController.oldImage,),
                  SizedBox(
                    height: 8,
                  ),
                  Loading_Button(
                      label: '${widget.data == null ? 'Create' :'Update'} Category',
                      status: data.addStatus,
                      loadingStatus: "${widget.data == null ? 'Creating' :'Updating'}",
                      onPressed: (){categoryController.createCategory(context:context);})
                ],
              ),
            ),
          );
        }
    );
  }
}
