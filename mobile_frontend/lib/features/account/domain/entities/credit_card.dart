import 'package:big_cart/features/account/domain/entities/transaction.dart';

class CreditCard {
  String? id;
  String name;
  String cardNumber;
  String expiryDate;
  String cvv;
  paymentProccessor proccessor;
  bool isDefault;

  CreditCard({
    this.id,
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.proccessor,
    this.isDefault = false,
  });
}
