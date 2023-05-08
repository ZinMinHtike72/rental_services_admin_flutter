import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:rental_services/screens/product/components/price_card.dart';

class Vendor_Details extends StatelessWidget {
  const Vendor_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Vendor_Provider>(
        builder: (context,data,child){
          return Scaffold(
            appBar: AppBar(
              title: Text("${data.vendor_details!.name}"),
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(image:NetworkImage(data.vendor_details!.profile ?? 'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg' ),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 7),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: data.vendor_details!.status != 0 ? Colors.greenAccent.withOpacity(0.3) : Colors.red.withOpacity(0.3)
                          ),
                          child: Text(data.vendor_details!.status != 0 ? 'Active':'Inactive'),
                        )
                      ],
                    ),
                    Price_Card(data: data.vendor_details!.shopName , type: 'Shop Name'),
                    SizedBox(
                      height: 10,
                    ),
                    Price_Card(data: data.vendor_details!.email , type: 'Email'),
                    SizedBox(
                      height: 10,
                    ),
                    Price_Card(data: data.vendor_details!.phone , type: 'Phone'),
                    if(data.vendor_details!.address != null)
                      Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Price_Card(data: data.vendor_details!.address! , type: 'Address'),
                      ],),
                    SizedBox(
                      height: 10,
                    ),
                    Price_Card(data: data.vendor_details!.joinDate , type: 'Join Date'),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
