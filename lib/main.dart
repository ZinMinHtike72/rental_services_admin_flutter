import 'package:flutter/material.dart';
import 'package:rental_services/screens/intro_screens/main_introscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/screens/home/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/providers.dart';
import 'package:rental_services/components/loading_screen.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'dart:convert';
import 'package:rental_services/services/api_services.dart';

void main() {
  runApp(
  MultiProvider(
      providers: providers,
      child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          toolbarHeight:60 ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3)
          ),
          color: Colors.indigoAccent.withOpacity(0.6),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),
          elevation: 2
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: FutureBuilder(
          future: Storage_Services.readLoginData(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data != null){
                final data =jsonDecode(snapshot.data.toString()) as Map;
                context.read<Login_Provider>().setLoginData(data: data);
                Api_Services.setLoginData(data);
                return Main_Screen();
              }else{
                return Main_Intro_Screen();
              }
            }else{
              return Loading_Screen();
            }
          }
      ),
    );
  }
}

