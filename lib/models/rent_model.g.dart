// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rent_Model _$Rent_ModelFromJson(Map<String, dynamic> json) => Rent_Model(
      id: json['_id'] as String,
      user: User_Model.fromJson(json['user'] as Map<String, dynamic>),
      product:
          Rent_Product_Model.fromJson(json['product'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      rentDuration: json['rent_duration'] as String,
      totalPrice: json['total_price'] as String,
      size: json['size'] as String,
      color: json['color'] as String,
      vendor:
          Rent_Vendor_Model.fromJson(json['vendor'] as Map<String, dynamic>),
      rentDate: json['rent_date'] as String,
      price: json['price/M'] as String,
      returnDate: json['return_date'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$Rent_ModelToJson(Rent_Model instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'product': instance.product,
      'phone': instance.phone,
      'name': instance.name,
      'address': instance.address,
      'rent_duration': instance.rentDuration,
      'total_price': instance.totalPrice,
      'size': instance.size,
      'color': instance.color,
      'vendor': instance.vendor,
      'rent_date': instance.rentDate,
      'price/M': instance.price,
      'return_date': instance.returnDate,
      'status': instance.status,
    };

User_Model _$User_ModelFromJson(Map<String, dynamic> json) => User_Model(
      name: json['name'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$User_ModelToJson(User_Model instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Rent_Product_Model _$Rent_Product_ModelFromJson(Map<String, dynamic> json) =>
    Rent_Product_Model(
      name: json['name'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$Rent_Product_ModelToJson(Rent_Product_Model instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Rent_Vendor_Model _$Rent_Vendor_ModelFromJson(Map<String, dynamic> json) =>
    Rent_Vendor_Model(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$Rent_Vendor_ModelToJson(Rent_Vendor_Model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
