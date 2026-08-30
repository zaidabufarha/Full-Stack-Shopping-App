import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [PaymentProcessorConverter()],
)
class CreditCardModel extends CreditCard {
  const CreditCardModel({
    super.id,
    required super.cardHolderName,
    required super.last4,
    required super.expiryDate,
    super.stripePaymentId = 'pm_mock_12345',
    required super.processor,
    super.isDefault = false,
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

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}
