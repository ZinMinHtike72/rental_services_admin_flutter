// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business_Model _$Business_ModelFromJson(Map<String, dynamic> json) =>
    Business_Model(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Business_ModelToJson(Business_Model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'media': instance.media,
    };
