import 'package:flutter/material.dart';
import 'package:rental_services/components/cus_input.dart';
import 'package:rental_services/components/cus_image_picker.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/controller/business_controller.dart';
import 'package:rental_services/controller/business_controller.dart';
class Business_Add extends StatefulWidget {
  Business_Model? data;
  Business_Add({Key? key,Business_Model? this.data}) : super(key: key);

  @override
  State<Business_Add> createState() => _Business_AddState();
}

class _Business_AddState extends State<Business_Add> {
  var businessController;
  @override
  void initState(){
    super.initState();
    businessController = Business_Controller(type: widget.data != null ?'update':null);
    if(widget.data != null){
      businessController.setName(widget.data!.name);
      businessController.setAddress(widget.data!.address);
      businessController.setOldImage(widget.data!.media!.media_link);
      businessController.setId(widget.data!.id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Business_Provider>(
        builder: (context,data,child){
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("${widget.data != null ? 'Update' : 'Add'} Business"),
              ),
              body:Container(
                padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                child:  Column(
                  children: [
                    Cus_Input(label: "Business Name", onChange: (data){
                      businessController.setName(data);
                    },errorText: data.error['name'],value: businessController.businessName,),
                    SizedBox(
                      height: 8,
                    ),
                    Cus_Input(label: "Address", onChange: (data){
                      businessController.setAddress(data);
                    },errorText: data.error['address'],value: businessController.address,),
                    SizedBox(
                      height: 8,
                    ),
                    Cus_Image_Picker(setData: (data){
                      businessController.setMedia(data);
                    }, label: "Select Image",errorText: data.error['media'],oldImage: businessController.oldImage,),
                    SizedBox(
                      height: 10,
                    ),
                    Loading_Button(label: "${widget.data == null ? 'Create' : 'Update'} Business", status: data.addStatus, loadingStatus: "${widget.data == null ? 'Creating' :'Updating'}", onPressed:(){
                      businessController.createBusiness(context:context);
                    } )
                  ],
                ),
              )
          );
        }
    );
  }
}
