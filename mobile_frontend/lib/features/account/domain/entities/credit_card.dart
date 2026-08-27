import 'package:big_cart/features/account/domain/entities/transaction.dart';

class CreditCard {
  String? id;
  String cardHolderName;
  String cardNumber;
  String expiryDate;
  String cvv;
  PaymentProcessor processor;
  bool isDefault;

  CreditCard({
    this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.processor,
    this.isDefault = false,
  });
}
