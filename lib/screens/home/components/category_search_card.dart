import 'package:flutter/material.dart';
import 'package:rental_services/models/category_model.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/category/category_details.dart';

class Category_Search_Card extends StatelessWidget {
  Category_Model data;
  Category_Search_Card({Key? key,required Category_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Category_Provider>().getCategoryDetails(id: data.id);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Category_Details()));
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
                    image: NetworkImage(data.media!),fit: BoxFit.cover
                )
            ),
          ),
          title: Text(data.name),
          trailing: Image.asset("lib/assets/icons/right-arrow.png",width: 17,color: Colors.indigo,),
        ),
      ),
    );
  }
}
