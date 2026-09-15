import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card.freezed.dart';

@freezed
abstract class CreditCard with _$CreditCard {
  const factory CreditCard({
    String? id,
    required String cardHolderName,
    required String last4,
    required String expiryDate,
    @Default('pm_mock_12345') String? stripePaymentId,
    required PaymentProcessor processor,
    @Default(false) bool isDefault,
  }) = _CreditCard;
}
