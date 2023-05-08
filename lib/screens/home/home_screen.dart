import 'package:flutter/material.dart';
import 'package:rental_services/screens/home/search_screen.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/providers/home_screen-provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:rental_services/screens/home/components/count_card.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/components/error_screen.dart';
import 'package:rental_services/components/no_data.dart';
import 'package:rental_services/providers/login_provider.dart';

class Home_Screen extends StatelessWidget {
  Home_Screen({Key? key}) : super(key: key);
  List? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text( "Rental Services (Admin Panel)"),
      ),
      body:  FutureBuilder(
          future: context.read<Home_Screen_Provider>().getList() ,
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Loading_Screen();
            }else{
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasData){
                  data = context.read<Home_Screen_Provider>().dataList;
                  return data!.length < 0 ? No_Data(alertText: "No List Here !") : GridView.builder(
                    itemCount: data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65
                    ),
                    itemBuilder: (context,index){
                      return Count_Card(data: data![index],);
                    },
                  );
                }
              }
            }
            return Error_Screen();
          }
      ),
    );
  }
}

