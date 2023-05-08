import 'package:flutter/material.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/screens/business/business_details.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:provider/provider.dart';

class Business_Search_Card extends StatelessWidget {
  Business_Model data;
  Business_Search_Card({Key? key,required Business_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Business_Provider>().getBusinessDetails(id: data.id);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Business_Details()));
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
                    image: NetworkImage(data.media!.media_link),fit: BoxFit.cover
                )
            ),
          ),
          title: Text(data.name),
          subtitle: Text("Address : ${data.address}"),
          trailing: Image.asset("lib/assets/icons/right-arrow.png",width: 17,color: Colors.indigo,),
        ),
      ),
    );
  }
}
