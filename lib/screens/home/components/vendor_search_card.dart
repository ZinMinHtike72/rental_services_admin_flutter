import 'package:flutter/material.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/vendor/vendor_details.dart';

class Vendor_Search_Card extends StatelessWidget {
  Vendor_Model data;
  Vendor_Search_Card({Key? key,required Vendor_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Vendor_Provider>().setVendorDetails(data: data);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Vendor_Details()));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.indigoAccent),
              borderRadius: BorderRadius.circular(5)
          ),
          leading: Container(
            width: 55,
            // height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(data.profile ?? 'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg' ),fit: BoxFit.cover
                )
            ),
          ),
          title: Text(data.name),
          subtitle: Text(data.shopName),
          trailing: Image.asset("lib/assets/icons/right-arrow.png",width: 17,color: Colors.indigo,),
        ),
      ),
    );
  }
}
