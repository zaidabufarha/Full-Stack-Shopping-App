// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  password: json['password'] as String? ?? '',
  imagePath:
      json['image_path'] as String? ?? 'assets/blank_profile_picture.png',
  defaultAddress: const AddressConverter().fromJson(json['default_address']),
  creditCard:
      (json['credit_card'] as List<dynamic>?)
          ?.map(const CreditCardConverter().fromJson)
          .toList() ??
      const [],
  address:
      (json['address'] as List<dynamic>?)
          ?.map(const AddressConverter().fromJson)
          .toList() ??
      const [],
  order:
      (json['order'] as List<dynamic>?)
          ?.map(const OrderConverter().fromJson)
          .toList() ??
      const [],
  transaction:
      (json['transaction'] as List<dynamic>?)
          ?.map(const TransactionConverter().fromJson)
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'password': instance.password,
  'image_path': instance.imagePath,
  'default_address': _$JsonConverterToJson<dynamic, Address>(
    instance.defaultAddress,
    const AddressConverter().toJson,
  ),
  'credit_card': instance.creditCard
      .map(const CreditCardConverter().toJson)
      .toList(),
  'address': instance.address.map(const AddressConverter().toJson).toList(),
  'order': instance.order.map(const OrderConverter().toJson).toList(),
  'transaction': instance.transaction
      .map(const TransactionConverter().toJson)
      .toList(),
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
