// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor_Model _$Vendor_ModelFromJson(Map<String, dynamic> json) => Vendor_Model(
      id: json['_id'] as String,
      name: json['name'] as String,
      shopName: json['shop_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      joinDate: json['join_date'] as String,
      profile: json['profile'] as String?,
      address: json['address'] as String?,
      status: json['status'] as int,
    );

Map<String, dynamic> _$Vendor_ModelToJson(Vendor_Model instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'shop_name': instance.shopName,
      'email': instance.email,
      'phone': instance.phone,
      'join_date': instance.joinDate,
      'profile': instance.profile,
      'address': instance.address,
      'status': instance.status,
    };
