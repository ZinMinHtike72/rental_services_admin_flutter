// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category_Model _$Category_ModelFromJson(Map<String, dynamic> json) =>
    Category_Model(
      name: json['name'] as String,
      id: json['id'] as String,
      media: json['media'] as String?,
      brand: json['brand'] == null
          ? null
          : Brand_Model.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Category_ModelToJson(Category_Model instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'media': instance.media,
      'brand': instance.brand,
    };
