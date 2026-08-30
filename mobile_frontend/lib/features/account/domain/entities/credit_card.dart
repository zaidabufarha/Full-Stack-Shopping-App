import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:equatable/equatable.dart';

class CreditCard extends Equatable {
  final String? id;
  final String cardHolderName;
  final String last4;
  final String expiryDate;
  final String? stripePaymentId;
  final PaymentProcessor processor;
  final bool isDefault;

  const CreditCard({
    this.id,
    required this.cardHolderName,
    required this.last4,
    required this.expiryDate,
    this.stripePaymentId = 'pm_mock_12345',
    required this.processor,
    this.isDefault = false,
  });

  CreditCard copyWith({
    String? id,
    String? cardHolderName,
    String? last4,
    String? expiryDate,
    String? stripePaymentId,
    PaymentProcessor? processor,
    bool? isDefault,
  }) {
    return CreditCard(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      last4: last4 ?? this.last4,
      expiryDate: expiryDate ?? this.expiryDate,
      stripePaymentId: stripePaymentId ?? this.stripePaymentId,
      processor: processor ?? this.processor,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        id,
        cardHolderName,
        last4,
        expiryDate,
        stripePaymentId,
        processor,
        isDefault,
      ];
}

