// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) =>
    OrderModel(
        id: json['id'] as String?,
        orderItem:
            (json['order_item'] as List<dynamic>?)
                ?.map(const CartItemConverter().fromJson)
                .toList() ??
            const [],
        datePlaced: DateTime.parse(json['date_placed'] as String),
        address: const AddressConverter().fromJson(json['address']),
        creditCard: const CreditCardConverter().fromJson(json['credit_card']),
        shippingMethod: json['shipping_method'] as String,
      )
      ..dateConfirmed = json['date_confirmed'] == null
          ? null
          : DateTime.parse(json['date_confirmed'] as String)
      ..dateShipped = json['date_shipped'] == null
          ? null
          : DateTime.parse(json['date_shipped'] as String)
      ..dateOutForDelivery = json['date_out_for_delivery'] == null
          ? null
          : DateTime.parse(json['date_out_for_delivery'] as String)
      ..dateDelivered = json['date_delivered'] == null
          ? null
          : DateTime.parse(json['date_delivered'] as String);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_item': instance.orderItem
          .map(const CartItemConverter().toJson)
          .toList(),
      'address': const AddressConverter().toJson(instance.address),
      'credit_card': const CreditCardConverter().toJson(instance.creditCard),
      'shipping_method': instance.shippingMethod,
      'date_placed': instance.datePlaced.toIso8601String(),
      'date_confirmed': instance.dateConfirmed?.toIso8601String(),
      'date_shipped': instance.dateShipped?.toIso8601String(),
      'date_out_for_delivery': instance.dateOutForDelivery?.toIso8601String(),
      'date_delivered': instance.dateDelivered?.toIso8601String(),
    };
