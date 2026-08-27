// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  id: json['id'] as String?,
  name: json['name'] as String,
  street: json['street'] as String,
  city: json['city'] as String,
  country: json['country'] as String,
  phone: json['phone'] as String,
  zipCode: json['zip_code'] as String,
  isDefault: json['is_default'] as bool? ?? false,
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'street': instance.street,
      'city': instance.city,
      'country': instance.country,
      'phone': instance.phone,
      'zip_code': instance.zipCode,
      'is_default': instance.isDefault,
    };
