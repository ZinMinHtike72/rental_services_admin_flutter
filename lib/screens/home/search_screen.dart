import 'package:flutter/material.dart';
import 'package:rental_services/components/back_button.dart';
import 'package:lottie/lottie.dart';
import 'package:rental_services/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/screens/home/components/searchNotFound.dart';
import 'package:rental_services/screens/home/components/search_list.dart';

class Search_Screen extends StatefulWidget {
  final String type;
   Search_Screen({Key? key,required String this.type}) : super(key: key);
  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  final _textController = TextEditingController();
  @override
  void initState(){
    super.initState();
    print(widget.type);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<Search_Provider>().setType(searchType: widget.type);
      context.read<Search_Provider>().clearData();
    });
  }
  @override
  Widget build(BuildContext context) {
    void searchFunction(value){
      context.read<Search_Provider>().searchData(key: value);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<Search_Provider>(
          builder: (context,data,child){
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Back_Button(),
                      SizedBox(
                        width:MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: _textController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value){
                            searchFunction(value);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:BorderRadius.circular(20)
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                              hintText: "search ${widget.type} here",
                              suffixIconConstraints: BoxConstraints(
                                  minWidth: 10
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    searchFunction(_textController.text);
                                  },
                                  child: Image.asset("lib/assets/icons/search.png",color: Colors.black,width: 25,),
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if(data.fetchStatus)
                  Expanded(
                      child:Column(
                        children: [
                          Lottie.asset("lib/assets/animations/search.json")
                        ],
                      )
                  ),
                if(!data.fetchStatus &&  data.data.length > 0 && _textController.text.length > 0)
                  Search_List(type: widget.type),
                if(!data.fetchStatus &&  data.data.length == 0 && _textController.text.length > 0)
                 SearchNotFound(),
              ],
            );
          },
        ),
      ),
    );
  }
}
