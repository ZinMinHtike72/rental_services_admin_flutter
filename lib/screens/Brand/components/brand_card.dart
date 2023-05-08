import 'package:flutter/material.dart';
import 'package:rental_services/screens/Brand/brand_details.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/brand_provider.dart';

class Brand_Card extends StatelessWidget {
  String name;
  String image;
  String id;
  Brand_Card({Key? key,required String this.name,required String this.image,required String this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Brand_Provider>().getBrandDetails(id: id);
        showBottomSheet(
            context: context,
            builder: (child){
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Brand_Details(),
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
