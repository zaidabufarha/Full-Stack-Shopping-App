import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
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
class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String imagePath;
  final Address? defaultAddress;
  final List<CreditCard> creditCard;
  final List<Address> address;
  final List<Order> order;
  final List<Transaction> transaction;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.password = '',
    this.imagePath = 'assets/blank_profile_picture.png',
    this.defaultAddress,
    this.creditCard = const [],
    this.address = const [],
    this.order = const [],
    this.transaction = const [],
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

  User toEntity() => User(
        name: name,
        email: email,
        phone: phone,
        password: password,
        imagePath: imagePath,
        defaultAddress: defaultAddress,
        creditCard: creditCard,
        address: address,
        order: order,
        transaction: transaction,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
