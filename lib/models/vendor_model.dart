import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'vendor_model.g.dart';
@JsonSerializable()
class Vendor_Model with ChangeNotifier{
  @JsonKey(name: "_id")
  String id;
  String name;
  @JsonKey(name: 'shop_name')
  String shopName;
  String email;
  String phone;
  @JsonKey(name: 'join_date')
  String joinDate;
  String? profile;
  String? address;
  int status;
  Vendor_Model({required String this.id,required String this.name,required String this.shopName,required String this.email,required String this.phone,required String this.joinDate,String? this.profile,String? this.address,required int this.status});

  factory Vendor_Model.fromJson(Map<String, dynamic> json) => _$Vendor_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Vendor_ModelToJson(this);
}