import 'package:flutter/material.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/components/app_bar_action_button.dart';
import 'package:rental_services/screens/product/product_add.dart';
import 'package:rental_services/components/image_carousel.dart';
import 'package:rental_services/screens/product/components/price_card.dart';
import 'package:rental_services/screens/product/components/multi_data_card.dart';
import 'package:rental_services/controller/product_controller.dart';
class Product_Details extends StatelessWidget {
  Product_Details({Key? key}) : super(key: key);
  final productController = Product_Controller();

  @override
  Widget build(BuildContext context) {
    return Consumer<Product_Provider>(
        builder: (context,data,child){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("${data.productDetails.name}"),
              actions: [
                App_Bar_Action_Button(iconImage: "lib/assets/icons/update.png",route:Product_Add(data:data.productDetails ,),width: 25 ,),
                GestureDetector(
                    onTap:(){
                      productController.showDialog(context: context, id: data.productDetails.id,name: data.productDetails.name);
                    },
                    child:Container(
                      margin: EdgeInsets.only(right: 12),
                      child:   Image.asset("lib/assets/icons/delete.png",color: Colors.white,width: 20,),
                    )
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Image_Carousel(imageList: [data.productDetails.mainThumbnail.media_link,...data.productDetails.multiImages.map((e) => e['media_link']).toList()]),
                  Container(
                    width:double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.478,
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Description",style: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("${data.productDetails.description}",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16
                                  ),),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if(data.productDetails.vendor != null)
                                Price_Card(data: "${data.productDetails.vendor!.name} ",type: 'Vendor'),
                              Price_Card(data: "${data.productDetails.price}\$ ",type: 'Price'),
                              Price_Card(data: data.productDetails.productCode,type: 'Product Code'),
                              Price_Card(data: data.productDetails.brand.name,type: 'Brand'),
                              Price_Card(data: data.productDetails.category.name,type: 'Category'),
                              Price_Card(data: data.productDetails.business.name,type: 'Business'),
                              Price_Card(data: data.productDetails.energyConsumption,type: 'Energy Consumption'),
                              Price_Card(data:"${data.productDetails.durationDate} Month",type: 'Duration Date'),
                              Price_Card(data:"${data.productDetails.insuranceDate} Month",type: 'Insurance Date'),
                              Text("Sizes",style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 20
                              ),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ...data.productDetails.size.map((e) => Multi_Data_Card(data: e,)).toList(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Extra Devices",style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 20
                              ),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ...data.productDetails.extraDevice.map((e) => Multi_Data_Card(data: e,)).toList(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Colors",style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 20
                              ),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ...data.productDetails.color.map((e) => Multi_Data_Card(data: e,)).toList(),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
