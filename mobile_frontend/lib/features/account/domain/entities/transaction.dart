import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

enum PaymentProcessor { mastercard, paypal, visa }

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required double amount,
    required DateTime createdAt,
    required PaymentProcessor paymentMethod,
  }) = _Transaction;
}
