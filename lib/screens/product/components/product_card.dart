import 'package:flutter/material.dart';
import 'package:rental_services/models/product_model.dart';
import 'package:rental_services/screens/product/product_details.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Product_Card extends StatelessWidget {
  Product_Model data;
  Product_Card({Key? key,required Product_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushDynamicScreen(context, screen: MaterialPageRoute(builder: (context)=>Product_Details()),withNavBar: true);
        context.read<Product_Provider>().setProductDetails(id:data.id);
      },
      child: Card(
        color: Colors.indigo[100],
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child:  Image.network(data.mainThumbnail.media_link,height: 120,fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(" ${data.name}",style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  letterSpacing: 1,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),),
              SizedBox(
                height: 4,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5),
                child: Text("Price :  ${data.price} \$",style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey.shade700,
                    letterSpacing: 1,
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
