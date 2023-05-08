// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand_Model _$Brand_ModelFromJson(Map<String, dynamic> json) => Brand_Model(
      name: json['name'] as String,
      id: json['id'] as String,
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Brand_ModelToJson(Brand_Model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'media': instance.media,
    };

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      id: json['id'] as String,
      media_link: json['media_link'] as String,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'media_link': instance.media_link,
    };
