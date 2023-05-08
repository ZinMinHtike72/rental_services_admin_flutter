import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'count_model.g.dart';

@JsonSerializable()
class Count_Model with ChangeNotifier{
  String name;
  int count;
  Count_Model({required String this.name,required int this.count});
  factory Count_Model.fromJson(Map<String, dynamic> json) => _$Count_ModelFromJson(json);
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$Count_ModelToJson(this);
}