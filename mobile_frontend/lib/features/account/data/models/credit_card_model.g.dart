// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardModel _$CreditCardModelFromJson(Map<String, dynamic> json) =>
    CreditCardModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      cardNumber: json['cardNumber'] as String,
      expiryDate: json['expiryDate'] as String,
      cvv: json['cvv'] as String,
      proccessor: $enumDecode(_$paymentProccessorEnumMap, json['proccessor']),
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'proccessor': _$paymentProccessorEnumMap[instance.proccessor]!,
      'isDefault': instance.isDefault,
    };

const _$paymentProccessorEnumMap = {
  paymentProccessor.mastercard: 'mastercard',
  paymentProccessor.paypal: 'paypal',
  paymentProccessor.visa: 'visa',
};
