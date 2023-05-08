import 'package:flutter/material.dart';
import 'package:rental_services/models/rent_model.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/rent_provider.dart';
import 'package:rental_services/screens/rent/rent_list.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rental_services/screens/rent/rent_details.dart';

class Rent_Card extends StatelessWidget {
  Rent_Model data;
  Rent_Card({Key? key,required Rent_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Rent_Provider>().setRentDetails(data: data);
        PersistentNavBarNavigator.pushNewScreen(context, screen:Rent_Details());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.indigo
            )
        ),
        child: ListTile(
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
            decoration: BoxDecoration(
                color: data.status == 1 ?  Colors.green :Colors.red,
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
            child: Text('${ data.status == 1 ?  'Renting' : 'Free Hold'}',style: TextStyle(
                color: Colors.white,
                fontSize: 13
            ),),
          ),
          title:Text("${data.name}",style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),
          subtitle:Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text("Product Name : ${data.product.name}"),
          ) ,
          tileColor: Colors.indigoAccent.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10,
            ),
          ),
        ),
      ),
    );
  }
}

