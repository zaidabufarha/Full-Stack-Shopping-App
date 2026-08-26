enum paymentProccessor { mastercard, paypal, visa }

class Transaction {
  double cost;
  DateTime timestamp;
  paymentProccessor proccessor;

  Transaction({
    required this.cost,
    required this.timestamp,
    required this.proccessor,
  });
}
