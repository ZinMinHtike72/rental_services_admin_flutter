import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'rent_model.g.dart';

@JsonSerializable()
class Rent_Model{
  @JsonKey(name: "_id")
  String id;
  User_Model user;
  Rent_Product_Model product;
  String phone;
  String name;
  String address;
  @JsonKey(name: 'rent_duration')
  String rentDuration;
  @JsonKey(name: 'total_price')
  String totalPrice;
  String size;
  String color;
  Rent_Vendor_Model vendor;
  @JsonKey(name: 'rent_date')
  String rentDate;
  @JsonKey(name: 'price/M')
  String price;
  @JsonKey(name: 'return_date')
  String returnDate;
  int status;
  Rent_Model({
    required String this.id,
    required User_Model this.user,
    required Rent_Product_Model this.product,
    required String this.phone,
    required String this.name,
    required String this.address,
    required String this.rentDuration,
    required String this.totalPrice,
    required String this.size,
    required String this.color,
    required Rent_Vendor_Model this.vendor,
    required String this.rentDate,
    required String this.price,
    required String this.returnDate,
    required int this.status
  });


  factory Rent_Model.fromJson(Map<String, dynamic> json) => _$Rent_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Rent_ModelToJson(this);
}

@JsonSerializable()
class User_Model{
  String name;
  String id;
  User_Model({required String this.name,required String this.id});
  factory User_Model.fromJson(Map<String, dynamic> json) => _$User_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$User_ModelToJson(this);
}

@JsonSerializable()
class Rent_Product_Model{
  String name;
  String id;
  Rent_Product_Model({required String this.name,required String this.id});
  factory Rent_Product_Model.fromJson(Map<String, dynamic> json) => _$Rent_Product_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Rent_Product_ModelToJson(this);
}

@JsonSerializable()
class Rent_Vendor_Model{
  String id;
  String name;
  Rent_Vendor_Model({required String this.id,required String this.name});
  factory Rent_Vendor_Model.fromJson(Map<String, dynamic> json) => _$Rent_Vendor_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Rent_Vendor_ModelToJson(this);
}