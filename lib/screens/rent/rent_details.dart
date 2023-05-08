import 'package:flutter/material.dart';
import 'package:rental_services/providers/rent_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/models/rent_model.dart';
import 'package:rental_services/screens/product/components/price_card.dart';
class Rent_Details extends StatelessWidget {
  Rent_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Rent_Provider>(
        builder: (context,data,child){
          Rent_Model rentDetails = data.rentDetails;
          return Scaffold(
            appBar: AppBar(
              title: Text("User Name : ${rentDetails.name}"),
            ),
            body:SingleChildScrollView(
              child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: rentDetails.status == 1 ?  Colors.green :Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 1),
                                spreadRadius: 1,
                                blurRadius: 10
                            )
                          ]
                      ),
                      child: Text('Rent Status : ${ rentDetails.status == 1 ?  'Renting' : 'Free Hold'}',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                    ),
                    //User
                    Price_Card(data: rentDetails.phone, type: 'Phone'),
                    Price_Card(data: rentDetails.address, type: 'Address'),
                    Price_Card(data: rentDetails.rentDuration, type: 'Rent Duration'),
                    Price_Card(data: rentDetails.totalPrice, type: 'Total Price'),
                    Price_Card(data: rentDetails.size, type: 'Size'),
                    Price_Card(data: rentDetails.color, type: 'Color'),
                    Price_Card(data: rentDetails.vendor.name, type: 'Vendor'),
                    Price_Card(data: rentDetails.size, type: 'Size'),
                    Price_Card(data: rentDetails.rentDate, type: 'Rent Date'),
                    Price_Card(data: rentDetails.price, type: 'Price'),
                    Price_Card(data: rentDetails.returnDate, type: 'Return Date'),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
