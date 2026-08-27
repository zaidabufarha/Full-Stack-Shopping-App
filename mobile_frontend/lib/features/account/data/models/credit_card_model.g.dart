// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardModel _$CreditCardModelFromJson(Map<String, dynamic> json) =>
    CreditCardModel(
      id: json['id'] as String?,
      cardHolderName: json['card_holder_name'] as String,
      last4: json['last4'] as String,
      expiryDate: json['expiry_date'] as String,
      stripePaymentId: json['stripe_payment_id'] as String? ?? 'pm_mock_12345',
      processor: const PaymentProcessorConverter().fromJson(json['processor']),
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card_holder_name': instance.cardHolderName,
      'last4': instance.last4,
      'expiry_date': instance.expiryDate,
      'stripe_payment_id': instance.stripePaymentId,
      'processor': const PaymentProcessorConverter().toJson(instance.processor),
      'is_default': instance.isDefault,
    };
