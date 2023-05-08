import 'package:flutter/material.dart';
import 'package:rental_services/screens/home/components/brand_search_card.dart';
import 'package:rental_services/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/home/components/category_search_card.dart';
import 'package:rental_services/screens/home/components/business_search_card.dart';
import 'package:rental_services/screens/home/components/product_search_card.dart';
import 'package:rental_services/screens/home/components/vendor_search_card.dart';
import 'package:rental_services/screens/rent/components/rent_card.dart';
class Search_List extends StatelessWidget {
  String type;
  Search_List({Key? key,required String this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          child: Consumer<Search_Provider>(
            builder: (context,data,child){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                height: MediaQuery.of(context).size.height *0.8,
                child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context,index){
                      switch(type){
                        case 'brand':
                          return Brand_Search_Card(data: data.data[index],);
                        case 'category':
                          return Category_Search_Card(data: data.data[index],);
                        case 'business':
                          return Business_Search_Card(data: data.data[index]);
                        case 'product':
                          return Product_Search_Card(data: data.data[index]);
                        case 'activeVendor':
                          return Vendor_Search_Card(data: data.data[index]);
                        case 'inactiveVendor':
                          return Vendor_Search_Card(data: data.data[index]);
                        case 'rent':
                          return Rent_Card(data: data.data[index]);
                      }
                    }
                )
              );
            },
      ),
    );
  }
}
