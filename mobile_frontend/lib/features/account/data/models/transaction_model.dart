import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [PaymentProcessorConverter()],
)
class TransactionModel extends Transaction {
  TransactionModel({
    required super.amount,
    required super.createdAt,
    required super.paymentMethod,
  });

  factory TransactionModel.fromEntity(Transaction entity) => TransactionModel(
    amount: entity.amount,
    createdAt: entity.createdAt,
    paymentMethod: entity.paymentMethod,
  );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
