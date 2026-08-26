import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card_model.g.dart';

@JsonSerializable(converters: [TransactionConverter()])
class CreditCardModel extends CreditCard {
  CreditCardModel({
    super.id,
    required super.name,
    required super.cardNumber,
    required super.expiryDate,
    required super.cvv,
    required super.proccessor,
    super.isDefault = false,
  });

  factory CreditCardModel.fromEntity(CreditCard entity) => CreditCardModel(
    id: entity.id,
    name: entity.name,
    cardNumber: entity.cardNumber,
    expiryDate: entity.expiryDate,
    cvv: entity.cvv,
    proccessor: entity.proccessor,
    isDefault: entity.isDefault,
  );

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('card_holder_name') && !mapped.containsKey('name')) {
      mapped['name'] = mapped['card_holder_name'];
    }
    if (mapped.containsKey('card_number') && !mapped.containsKey('cardNumber')) {
      mapped['cardNumber'] = mapped['card_number'];
    }
    if (mapped.containsKey('expiry_date') && !mapped.containsKey('expiryDate')) {
      mapped['expiryDate'] = mapped['expiry_date'];
    }
    if (mapped.containsKey('processor') && !mapped.containsKey('proccessor')) {
      mapped['proccessor'] = mapped['processor'];
    }
    if (mapped['id'] != null) {
      mapped['id'] = mapped['id'].toString();
    }
    return _$CreditCardModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}
