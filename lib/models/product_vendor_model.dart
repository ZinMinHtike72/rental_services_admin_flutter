import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product_vendor_model.g.dart';

@JsonSerializable()
class Product_Vendor_Model with ChangeNotifier{
  String id;
  String name;
  Product_Vendor_Model({required String this.id,required String this.name});

  factory Product_Vendor_Model.fromJson(Map<String, dynamic> json) => _$Product_Vendor_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Product_Vendor_ModelToJson(this);
}
