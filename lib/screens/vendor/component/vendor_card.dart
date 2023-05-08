import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/screens/vendor/vendor_details.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/vendor_provider.dart';
class Vendor_Card extends StatelessWidget {
  Vendor_Model data;
  bool? isShow;
  Function(String id,bool value)? onChanged;
  Vendor_Card({Key? key,required Vendor_Model this.data,bool? this.isShow,Function(String id,bool value)? this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Vendor_Details()));
        context.read<Vendor_Provider>().setVendorDetails(data: data);
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.indigoAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
        ),
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
          height: MediaQuery.of(context).size.height * 0.28,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                child:  Image.network(data.profile ?? 'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg',height: 80,width: double.infinity,),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${data.name}",style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                  if(isShow != null)
                    Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                        value: data.status == 1 ? true : false,
                        onChanged: (bool value){
                          onChanged!(data.id,value);
                        },
                        activeColor: Colors.indigoAccent,
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset("lib/assets/icons/mobile.png",width: 23,),
                  SizedBox(
                    width: 7,
                  ),
                  Text("${data.phone}")
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset("lib/assets/icons/shop.png",width: 20,),
                  SizedBox(
                    width: 7,
                  ),
                  Text("${data.shopName}")
                ],
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
