// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardModel _$CreditCardModelFromJson(Map<String, dynamic> json) =>
    CreditCardModel(
      id: json['id'] as String?,
      cardHolderName: json['card_holder_name'] as String,
      cardNumber: json['card_number'] as String,
      expiryDate: json['expiry_date'] as String,
      cvv: json['cvv'] as String,
      processor: const PaymentProcessorConverter().fromJson(json['processor']),
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card_holder_name': instance.cardHolderName,
      'card_number': instance.cardNumber,
      'expiry_date': instance.expiryDate,
      'cvv': instance.cvv,
      'processor': const PaymentProcessorConverter().toJson(instance.processor),
      'is_default': instance.isDefault,
    };
