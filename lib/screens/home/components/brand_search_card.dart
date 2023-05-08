import 'package:flutter/material.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/screens/Brand/brand_details.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Brand_Search_Card extends StatelessWidget {
  Brand_Model data;
  Brand_Search_Card({Key? key,required Brand_Model this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<Brand_Provider>().getBrandDetails(id: data.id);
        PersistentNavBarNavigator.pushDynamicScreen(context, screen:  MaterialPageRoute(builder: (context)=>Brand_Details()),withNavBar: true);
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
          trailing: Image.asset("lib/assets/icons/right-arrow.png",width: 17,color: Colors.indigo,),
        ),
      ),
    );
  }
}
