import 'package:flutter/material.dart';
import 'package:rental_services/screens/category/category_details.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/category_provider.dart';
class Category_Card extends StatelessWidget {
  String name;
  String image;
  String id;
  Category_Card({Key? key,required String this.name,required String this.image,required String this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        context.read<Category_Provider>().getCategoryDetails(id: id);
        showBottomSheet(
            context: context,
            builder: (child){
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Category_Details(),
              );
            });
      },
      child: Card(
        color: Colors.indigo[100],
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            children: [
              Container(
                width: double.infinity,
                child:  Image.network(image,height: 120,fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(name,textAlign: TextAlign.center,style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  letterSpacing: 1,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
