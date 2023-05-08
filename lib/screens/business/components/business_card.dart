import 'package:flutter/material.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/business/business_details.dart';

class Business_Card extends StatelessWidget {
  Business_Model data;
  Business_Card({Key? key,required Business_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Business_Provider>().getBusinessDetails(id:data.id);
        showBottomSheet(
            context: context,
            builder: (child){
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Business_Details(),
              );
            });
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
                child:  Image.network(data.media!.media_link,height: 120,fit: BoxFit.cover,),
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
                  child:  Text("Address :  ${data.address}",style: TextStyle(
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
