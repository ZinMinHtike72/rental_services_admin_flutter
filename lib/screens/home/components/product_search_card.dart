import 'package:flutter/material.dart';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/product/product_details.dart';

class Product_Search_Card extends StatelessWidget {
  Product_Model data;
  Product_Search_Card({Key? key,required Product_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Product_Provider>().setProductDetails(id: data.id);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Product_Details()));
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
                    image: NetworkImage(data.mainThumbnail!.media_link),fit: BoxFit.cover
                )
            ),
          ),
          title: Text(data.name),
          trailing:  Image.asset("lib/assets/icons/right-arrow.png",width: 17,color: Colors.indigo,),
        ),
      ),
    );
  }
}
