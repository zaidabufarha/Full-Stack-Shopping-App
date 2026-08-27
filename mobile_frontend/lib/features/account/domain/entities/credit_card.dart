import 'package:big_cart/features/account/domain/entities/transaction.dart';

class CreditCard {
  String? id;
  String cardHolderName;
  String last4;
  String expiryDate;
  String? stripePaymentId;
  PaymentProcessor processor;
  bool isDefault;

  CreditCard({
    this.id,
    required this.cardHolderName,
    required this.last4,
    required this.expiryDate,
    this.stripePaymentId = 'pm_mock_12345',
    required this.processor,
    this.isDefault = false,
  });
}
