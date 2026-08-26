import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
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
    required super.number,
    required super.password,
    super.imagePath,
    super.defaultAddress,
    super.creditCardList = const [],
    super.addressList = const [],
    super.orderList = const [],
    super.transactionList = const [],
  });

  factory UserModel.fromEntity(User entity) => UserModel(
    name: entity.name,
    email: entity.email,
    number: entity.number,
    password: entity.password,
    imagePath: entity.imagePath,
    defaultAddress: entity.defaultAddress,
    creditCardList: entity.creditCardList,
    addressList: entity.addressList,
    orderList: entity.orderList,
    transactionList: entity.transactionList,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Map GraphQL user response fields
    if (json.containsKey('phone') && !json.containsKey('number')) {
      json['number'] = json['phone'];
    }
    if (json.containsKey('image_path') && !json.containsKey('imagePath')) {
      json['imagePath'] = json['image_path'];
    }
    if (json.containsKey('address') && !json.containsKey('addressList')) {
      json['addressList'] = json['address'];
    }
    if (json.containsKey('credit_card') &&
        !json.containsKey('creditCardList')) {
      json['creditCardList'] = json['credit_card'];
    }
    if (json.containsKey('order') && !json.containsKey('orderList')) {
      json['orderList'] = json['order'];
    }
    if (json.containsKey('transaction') &&
        !json.containsKey('transactionList')) {
      json['transactionList'] = json['transaction'];
    }
    json['password'] ??= '';
    json['creditCardList'] ??= [];
    json['addressList'] ??= [];
    json['orderList'] ??= [];
    json['transactionList'] ??= [];
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
