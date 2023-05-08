import 'package:flutter/material.dart';
import 'package:rental_services/screens/vendor/component/vendor_card.dart';
import 'package:rental_services/models/vendor_model.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_services/screens/vendor/active_vendor_list.dart';
import 'package:rental_services/screens/vendor/inactive_vendor_list.dart';
import 'package:rental_services/controller/vendor_controller.dart';

class For_Show_List extends StatelessWidget {
  String label;
  List<Vendor_Model> data;
  String type;
  For_Show_List({Key? key,required String this.label,required List<Vendor_Model> this.data,required String this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void changeStatus(String id,bool value){
      Vendor_Controller().changeStatus(context: context, data: value,id:id);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$label",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => type == 'active' ? Active_Vendor_List() : Inactive_Vendor_List() ));
                  },
                  child: Row(
                    children: [
                      Text("View All",style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        width: 6,
                      ),
                      Image.asset("lib/assets/icons/right-arrow.png",width: 16,color: Colors.indigoAccent,)
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                  ...List.generate(data.length < 5 ? data.length : 5, (index) => Vendor_Card(data: data[index],isShow: true,onChanged: changeStatus,)),
               ],
             ),
           ),

        ],
      ),
    );
  }
}
