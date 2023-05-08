import 'package:flutter/material.dart';

class Drop_Down_Select extends StatelessWidget {

   String label;
   String? errorText;
   String? dropdownValue;
   bool? fetchStatus;
   List list ;
   Function(String data) onChanged;
   Drop_Down_Select({Key? key,required String this.label,String? this.errorText,required List this.list,required Function(String data) this.onChanged, String? this.dropdownValue,bool? this.fetchStatus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey.shade600
            ),),
            SizedBox(
              width: 10,
            ),
            if(fetchStatus != null)
              if(fetchStatus!)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          elevation: 20,
          hint: Text("$label",style: TextStyle(
            color: Colors.white
          ),),
          iconSize: 20,
          iconEnabledColor: Colors.white,
          // icon: ,
          decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder( //<-- SEE HERE
            //   borderSide: BorderSide(color: Colors.black, width: 2),
            // ),
            // focusedBorder: OutlineInputBorder( //<-- SEE HERE
            //   borderSide: BorderSide(color: Colors.white, width: 1),
            //   borderRadius: BorderRadius.circular(10)
            // ),
            filled: true,
            fillColor: Colors.indigoAccent.shade100,
          ),
          dropdownColor: Colors.indigoAccent,
          value: dropdownValue,
          onChanged: ( newValue) {
            onChanged(newValue ?? "");
            // setState(() {
            //   dropdownValue = newValue!;
            // });
          },
          items: list.map<DropdownMenuItem>(( value) {
            return DropdownMenuItem<String>(
              value: value['id'],
              child: Text(
                value['name'],
                style: TextStyle(fontSize: 17,color: Colors.white),
              ),
            );
          }).toList(),
        ),
        if(errorText != null) Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(errorText!,style: TextStyle(
            color: Colors.red,
            fontSize: 13,
            // fontWeight: FontWeight.bold
          ),),
        )
      ],
    );
  }
}
