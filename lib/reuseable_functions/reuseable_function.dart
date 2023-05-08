class Reuseable_Function{
  static bool checkIsHave({String? value}){
    final trimValue = value!.trim();
    List valueToArray = trimValue.split("");
    if(valueToArray.length == 0){
      return false;
    }else{
      return true;
    }
  }

  static bool checkIsEmail ({String? value}){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!)){
      return true;
    }else{
      return false;
    }
  }

  static List Drop_Down_Data ({required List value}){
   return value.map((e){
     return {
       'id' : e.id,
       'name' : e.name
     };
   }).toList();
  }

  static Map convertMonthsToYearsAndMonths(int totalMonths) {
    int years = totalMonths ~/ 12;
    int months = totalMonths % 12;
    return {'year':years,'month':months};
  }

}