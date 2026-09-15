import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [PaymentProcessorConverter()],
)
class CreditCardModel {
  final String? id;
  final String cardHolderName;
  final String last4;
  final String expiryDate;
  final String? stripePaymentId;
  final PaymentProcessor processor;
  final bool isDefault;

  const CreditCardModel({
    this.id,
    required this.cardHolderName,
    required this.last4,
    required this.expiryDate,
    this.stripePaymentId = 'pm_mock_12345',
    required this.processor,
    this.isDefault = false,
  });

  factory CreditCardModel.fromEntity(CreditCard entity) => CreditCardModel(
        id: entity.id,
        cardHolderName: entity.cardHolderName,
        last4: entity.last4,
        expiryDate: entity.expiryDate,
        stripePaymentId: entity.stripePaymentId,
        processor: entity.processor,
        isDefault: entity.isDefault,
      );

  CreditCard toEntity() => CreditCard(
        id: id,
        cardHolderName: cardHolderName,
        last4: last4,
        expiryDate: expiryDate,
        stripePaymentId: stripePaymentId,
        processor: processor,
        isDefault: isDefault,
      );

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}
