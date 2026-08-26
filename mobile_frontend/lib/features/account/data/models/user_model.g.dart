// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String,
  email: json['email'] as String,
  number: json['number'] as String,
  password: json['password'] as String,
  imagePath: json['imagePath'] as String? ?? 'assets/blank_profile_picture.png',
  defaultAddress: _$JsonConverterFromJson<Map<String, dynamic>, Address>(
    json['defaultAddress'],
    const AddressConverter().fromJson,
  ),
  creditCardList:
      (json['creditCardList'] as List<dynamic>?)
          ?.map(
            (e) =>
                const CreditCardConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  addressList:
      (json['addressList'] as List<dynamic>?)
          ?.map(
            (e) => const AddressConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  orderList:
      (json['orderList'] as List<dynamic>?)
          ?.map(
            (e) => const OrderConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  transactionList:
      (json['transactionList'] as List<dynamic>?)
          ?.map(
            (e) => const TransactionConverter().fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'number': instance.number,
  'password': instance.password,
  'imagePath': instance.imagePath,
  'defaultAddress': _$JsonConverterToJson<Map<String, dynamic>, Address>(
    instance.defaultAddress,
    const AddressConverter().toJson,
  ),
  'creditCardList': instance.creditCardList
      .map(const CreditCardConverter().toJson)
      .toList(),
  'addressList': instance.addressList
      .map(const AddressConverter().toJson)
      .toList(),
  'orderList': instance.orderList.map(const OrderConverter().toJson).toList(),
  'transactionList': instance.transactionList
      .map(const TransactionConverter().toJson)
      .toList(),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
