import 'package:flutter/material.dart';
import 'package:rental_services/components/drop_down_select.dart';
class Select_Month extends StatefulWidget {
  String label;
  Map? value;
  String? errorText;
  Function(Map data) onChange;
  Select_Month({Key? key,required Function(Map data) this.onChange,required String this.label,Map? this.value,String? this.errorText}) : super(key: key);

  @override
  State<Select_Month> createState() => _Select_MonthState();
}

class _Select_MonthState extends State<Select_Month> {
  List years = [];
  List months = [];
  Map duration = {'year':0,'month':0};
  Map? forShow;
  @override
  void initState(){
    super.initState();
    for(var i =0 ; i <= 100;i++){
      years.add({'id':"$i",'name':"$i"});
      if(i <= 12){
        months.add({'id':"$i",'name':"$i"});
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey.shade600
        ),),
        SizedBox(
          height: 7,
        ),
        Container(
          height: 100,
          child: GridView(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Drop_Down_Select(label: "By Year", list: years, onChanged: (value){
                  setState(() {
                    duration['year'] = value;
                  });
                  widget.onChange(duration);
                },dropdownValue: widget.value?['year'].toString(),),
              ),
              Drop_Down_Select(label: "By Month", list: months, onChanged: (value){
                setState(() {
                  duration['month'] = value;
                });
                widget.onChange(duration);
              },dropdownValue: widget.value?['month'].toString(),),
            ],
          ),
        ),
        if(widget.errorText != null)
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(widget.errorText!,style: TextStyle(
                color: Colors.red.shade700,
              fontSize: 12
            ),),
          )
      ],
    );
  }
}
