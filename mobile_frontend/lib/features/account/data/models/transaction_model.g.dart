// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      paymentMethod: const PaymentProcessorConverter().fromJson(
        json['payment_method'],
      ),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
      'payment_method': const PaymentProcessorConverter().toJson(
        instance.paymentMethod,
      ),
    };
