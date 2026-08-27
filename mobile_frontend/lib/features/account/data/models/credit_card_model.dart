import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [PaymentProcessorConverter()],
)
class CreditCardModel extends CreditCard {
  CreditCardModel({
    super.id,
    required super.cardHolderName,
    required super.cardNumber,
    required super.expiryDate,
    required super.cvv,
    required super.processor,
    super.isDefault = false,
  });

  factory CreditCardModel.fromEntity(CreditCard entity) => CreditCardModel(
        id: entity.id,
        cardHolderName: entity.cardHolderName,
        cardNumber: entity.cardNumber,
        expiryDate: entity.expiryDate,
        cvv: entity.cvv,
        processor: entity.processor,
        isDefault: entity.isDefault,
      );

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}
