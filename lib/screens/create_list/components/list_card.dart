import 'package:flutter/material.dart';

class List_Card extends StatelessWidget {
    final String label;
    final String icon;
    final Widget route;
   List_Card({Key? key,required String this.label,required String this.icon,required Widget this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> route));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(10)
          ),
          leading: Image.asset(icon,color: Colors.indigo,),
          title: Text(label),
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          trailing:  Image.asset('lib/assets/icons/right-arrow.png',width: 20,color: Colors.indigo,),
        ),
      ),
    );
  }
}
