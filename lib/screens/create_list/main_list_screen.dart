import 'package:flutter/material.dart';
import 'package:rental_services/screens/create_list/components/list_card.dart';
import 'package:rental_services/screens/Brand/brand_list.dart';
import 'package:rental_services/screens/category/category_list.dart';
import 'package:rental_services/screens/business/business_list.dart';
import 'package:rental_services/screens/product/product_list.dart';
import 'package:rental_services/screens/vendor/main_vendor_page.dart';
import 'package:rental_services/screens/rent/rent_list.dart';

class Main_List_Screen extends StatelessWidget {
   Main_List_Screen({Key? key}) : super(key: key);
  final List crudList = [
    ['Brand',"lib/assets/icons/brand.png",Brand_List()],
    ['Category',"lib/assets/icons/category.png",Category_List()],
    ['Business',"lib/assets/icons/cooperation.png",Business_List()],
    ['Product',"lib/assets/icons/product.png",Product_List()],
    ['Rent',"lib/assets/icons/desktop-computer.png",Rent_List()],
    ['Vendor',"lib/assets/icons/provision.png",Main_Vendor_Page()],

  ];
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Admin Side"),
      ),
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: MediaQuery.of(context).size.height,
          child:  ListView.builder(
            itemCount: crudList.length,
            itemBuilder: (BuildContext context,int index){
              return List_Card(label: crudList[index][0],icon: crudList[index][1],route:crudList[index][2] ,);
            },
          ),
        )
      ),
    );
  }
}

