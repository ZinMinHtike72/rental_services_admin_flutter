
import 'package:json_annotation/json_annotation.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:flutter/foundation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category_Model with ChangeNotifier{
  String name;
  // @JsonKey(name: "_id")
  String id;
  String? media;
  Brand_Model? brand;

  Category_Model({required String this.name,required String this.id,String? this.media,Brand_Model? this.brand});
  factory Category_Model.fromJson(Map<String, dynamic> json) => _$Category_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Category_ModelToJson(this);
}

