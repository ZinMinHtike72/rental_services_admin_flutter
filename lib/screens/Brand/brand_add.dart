import 'package:flutter/material.dart';
import 'package:rental_services/components/cus_input.dart';
import 'package:rental_services/components/cus_image_picker.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/controller/brand_controller.dart';
class Brand_Add extends StatefulWidget {
  Brand_Model? data;
  Brand_Add({Key? key,Brand_Model? this.data}) : super(key: key);
  @override
  State<Brand_Add> createState() => _Brand_AddState();
}

class _Brand_AddState extends State<Brand_Add> {
  var brandController;
  @override
  void initState(){
    super.initState();
    brandController =  Brand_Controller(type: widget.data != null ? 'update' :null);

    if(widget.data != null){
      brandController.getBrandName(widget.data!.name);
      brandController.setOldImage(widget.data!.media!.media_link);
      brandController.setId(widget.data!.id);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.data == null ? "Add" : "Update"} Brand"),
      ),
      body: Consumer<Brand_Provider>(
        builder: (context,data,child){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Column(
              children: [
                Cus_Input(label: "Brand Name",onChange: (data){
                  brandController.getBrandName(data);
                },errorText:data.error['nameError'],value: brandController.brandName,),
                Cus_Image_Picker(setData: (data){
                  brandController.getBrandMedia(data);
                },label: "Brand Image",errorText: data.error['imageError'],oldImage: brandController.oldImage,),
                SizedBox(
                  height: 8,
                ),
                Loading_Button(
                    label: '${widget.data == null ? 'Create' : 'Update'} Brand',
                    status: data.addStatus,
                    loadingStatus: "${widget.data == null ? 'Creating' :'Updating'}",
                    onPressed: (){brandController.createBrand(context: context);})
              ],
            ),
          );
        },
      ),
    );
  }
}
