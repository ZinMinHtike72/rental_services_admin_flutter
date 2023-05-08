// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product_Model _$Product_ModelFromJson(Map<String, dynamic> json) =>
    Product_Model(
      id: json['_id'] as String,
      name: json['name'] as String,
      energyConsumption: json['energy_comsumption'] as String,
      color: json['color'] as List<dynamic>,
      size: json['size'] as List<dynamic>,
      extraDevice: json['extra_device'] as List<dynamic>,
      description: json['description'] as String?,
      mainThumbnail:
          Media.fromJson(json['main_thambnail'] as Map<String, dynamic>),
      multiImages: json['multi_images'] as List<dynamic>,
      productCode: json['product_code'] as String,
      brand: Brand_Model.fromJson(json['brand'] as Map<String, dynamic>),
      category:
          Category_Model.fromJson(json['category'] as Map<String, dynamic>),
      durationDate: json['duration_date'] as int,
      insuranceDate: json['insurence_date'] as int,
      business:
          Business_Model.fromJson(json['business'] as Map<String, dynamic>),
      price: json['price'] as String,
      vendor: json['vendor'] == null
          ? null
          : Product_Vendor_Model.fromJson(
              json['vendor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Product_ModelToJson(Product_Model instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'energy_comsumption': instance.energyConsumption,
      'color': instance.color,
      'size': instance.size,
      'extra_device': instance.extraDevice,
      'description': instance.description,
      'main_thambnail': instance.mainThumbnail,
      'multi_images': instance.multiImages,
      'product_code': instance.productCode,
      'brand': instance.brand,
      'category': instance.category,
      'duration_date': instance.durationDate,
      'insurence_date': instance.insuranceDate,
      'business': instance.business,
      'vendor': instance.vendor,
    };
