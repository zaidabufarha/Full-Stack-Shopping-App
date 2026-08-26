// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      cost: (json['cost'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      proccessor: $enumDecode(_$paymentProccessorEnumMap, json['proccessor']),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'cost': instance.cost,
      'timestamp': instance.timestamp.toIso8601String(),
      'proccessor': _$paymentProccessorEnumMap[instance.proccessor]!,
    };

const _$paymentProccessorEnumMap = {
  paymentProccessor.mastercard: 'mastercard',
  paymentProccessor.paypal: 'paypal',
  paymentProccessor.visa: 'visa',
};
