import 'package:json_annotation/json_annotation.dart';
import 'package:rental_services/models/brand_model.dart';
import 'package:rental_services/models/category_model.dart';
import 'package:rental_services/models/business_model.dart';
import 'package:rental_services/models/product_vendor_model.dart';

part 'product_model.g.dart';
@JsonSerializable()
class Product_Model{
    @JsonKey(name: "_id")
    String  id;
    String price;
    String name;
    @JsonKey(name: "energy_comsumption")
    String energyConsumption;
    List color;
    List size;
    @JsonKey(name: 'extra_device')
    List extraDevice;
    String? description;
    @JsonKey(name: "main_thambnail")
    Media mainThumbnail;
    @JsonKey(name: "multi_images")
    List multiImages;
    @JsonKey(name: 'product_code')
    String productCode;
    Brand_Model brand;
    Category_Model category;
    @JsonKey(name: 'duration_date')
    int durationDate;
    @JsonKey(name: 'insurence_date')
    int insuranceDate;
    Business_Model business;
    Product_Vendor_Model? vendor;
    Product_Model({
    required String this.id,
    required String this.name,
    required String this.energyConsumption,
    required List this.color,
    required List this.size,
    required List this.extraDevice,
     String? this.description,
    required Media this.mainThumbnail,
    required  List this.multiImages,
    required String this.productCode,
    required Brand_Model this.brand,
    required Category_Model this.category,
    required int this.durationDate,
    required int this.insuranceDate,
    required Business_Model this.business,
    required String this.price,
    Product_Vendor_Model? this.vendor
    });
    factory Product_Model.fromJson(Map<String, dynamic> json) => _$Product_ModelFromJson(json);
    /// Connect the generated [_$PersonToJson] function to the `toJson` method.
    Map<String, dynamic> toJson() => _$Product_ModelToJson(this);
}