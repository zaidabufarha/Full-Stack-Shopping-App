// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) =>
    OrderModel(
        id: (json['id'] as num?)?.toInt(),
        productList: (json['productList'] as List<dynamic>)
            .map(
              (e) =>
                  const CartItemConverter().fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        datePlaced: DateTime.parse(json['datePlaced'] as String),
        shippingAddress: const AddressConverter().fromJson(
          json['shippingAddress'] as Map<String, dynamic>,
        ),
        creditCard: const CreditCardConverter().fromJson(
          json['creditCard'] as Map<String, dynamic>,
        ),
        shippingMethod: json['shippingMethod'] as String,
      )
      ..dateConfirmed = json['dateConfirmed'] == null
          ? null
          : DateTime.parse(json['dateConfirmed'] as String)
      ..dateShipped = json['dateShipped'] == null
          ? null
          : DateTime.parse(json['dateShipped'] as String)
      ..dateOutForDelivery = json['dateOutForDelivery'] == null
          ? null
          : DateTime.parse(json['dateOutForDelivery'] as String)
      ..dateDelivered = json['dateDelivered'] == null
          ? null
          : DateTime.parse(json['dateDelivered'] as String);

Map<String, dynamic> _$OrderModelToJson(
  OrderModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'productList': instance.productList
      .map(const CartItemConverter().toJson)
      .toList(),
  'datePlaced': instance.datePlaced.toIso8601String(),
  'shippingAddress': const AddressConverter().toJson(instance.shippingAddress),
  'creditCard': const CreditCardConverter().toJson(instance.creditCard),
  'shippingMethod': instance.shippingMethod,
  'dateConfirmed': instance.dateConfirmed?.toIso8601String(),
  'dateShipped': instance.dateShipped?.toIso8601String(),
  'dateOutForDelivery': instance.dateOutForDelivery?.toIso8601String(),
  'dateDelivered': instance.dateDelivered?.toIso8601String(),
};
