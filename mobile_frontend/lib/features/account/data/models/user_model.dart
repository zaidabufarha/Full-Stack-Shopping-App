import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [
    AddressConverter(),
    CreditCardConverter(),
    OrderConverter(),
    TransactionConverter(),
  ],
)
class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.phone,
    super.password = '',
    super.imagePath,
    super.defaultAddress,
    super.creditCard = const [],
    super.address = const [],
    super.order = const [],
    super.transaction = const [],
  });

  factory UserModel.fromEntity(User entity) => UserModel(
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        password: entity.password,
        imagePath: entity.imagePath,
        defaultAddress: entity.defaultAddress,
        creditCard: entity.creditCard,
        address: entity.address,
        order: entity.order,
        transaction: entity.transaction,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
