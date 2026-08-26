import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends Transaction {
  TransactionModel({
    required super.cost,
    required super.timestamp,
    required super.proccessor,
  });

  factory TransactionModel.fromEntity(Transaction entity) => TransactionModel(
        cost: entity.cost,
        timestamp: entity.timestamp,
        proccessor: entity.proccessor,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('amount') && !mapped.containsKey('cost')) {
      mapped['cost'] = (mapped['amount'] is num)
          ? (mapped['amount'] as num).toDouble()
          : double.tryParse(mapped['amount'].toString()) ?? 0.0;
    }
    if (mapped.containsKey('created_at') && !mapped.containsKey('timestamp')) {
      mapped['timestamp'] = mapped['created_at'];
    }
    if (mapped.containsKey('payment_method') &&
        !mapped.containsKey('proccessor')) {
      final method = mapped['payment_method'].toString().toLowerCase();
      mapped['proccessor'] = method.contains('visa')
          ? 'visa'
          : (method.contains('master') ? 'mastercard' : 'paypal');
    }
    return _$TransactionModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
