enum PaymentProcessor { mastercard, paypal, visa }

class Transaction {
  double amount;
  DateTime createdAt;
  PaymentProcessor paymentMethod;

  Transaction({
    required this.amount,
    required this.createdAt,
    required this.paymentMethod,
  });
}
