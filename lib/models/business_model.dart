import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:rental_services/models/brand_model.dart';

part 'business_model.g.dart';
@JsonSerializable()
class Business_Model with ChangeNotifier{
  String id;
  String name;
  String? address;
  Media? media;

  Business_Model({required String this.id,required String this.name,String? this.address,Media? this.media});
  factory Business_Model.fromJson(Map<String, dynamic> json) => _$Business_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Business_ModelToJson(this);
}