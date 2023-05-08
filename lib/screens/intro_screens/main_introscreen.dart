import 'package:flutter/material.dart';
import 'package:rental_services/screens/intro_screens/first_intro_screen.dart';
import 'package:rental_services/screens/intro_screens/second_intro_screen.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';

class Main_Intro_Screen extends StatefulWidget {

  const Main_Intro_Screen({Key? key}) : super(key: key);

  @override
  State<Main_Intro_Screen> createState() => _Main_Intro_ScreenState();
}

class _Main_Intro_ScreenState extends State<Main_Intro_Screen> {
  final _pageController = PageController();
  int _currentIndex = 0;
  void changePage (){
    _pageController.jumpToPage(1);
    setState(() {
      _currentIndex = 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child:Stack(
            children: [
              PageView(
                onPageChanged: (int index){
                  setState(() {
                    _currentIndex = index;
                  });
                },
                controller: _pageController ,
                children: [
                  First_Intro_Screen(onClick:changePage ,),
                  Second_Intro_Screen()
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: PageViewIndicator(
                    currentColor:Colors.indigo.shade700,
                    otherColor: Colors.white,
                    currentSize: 17,
                    borderRadius: 10,
                    length: 2,
                    currentIndex: _currentIndex,
                  ),
                ),
              )

            ],
          )
      ),
    );
  }
}



