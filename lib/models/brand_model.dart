import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'brand_model.g.dart';
@JsonSerializable()
class Brand_Model with ChangeNotifier{
  final String id ;
  final String name;
  Media? media;
  Brand_Model({required String this.name,required String this.id,Media? this.media});
  factory Brand_Model.fromJson(Map<String, dynamic> json) => _$Brand_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Brand_ModelToJson(this);
}

@JsonSerializable()
class Media with ChangeNotifier{
  String id;
  String media_link;
  Media({required  this.id,required  this.media_link});
  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}

