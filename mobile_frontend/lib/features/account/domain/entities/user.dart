import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String name,
    required String email,
    required String phone,
    @Default('') String password,
    @Default('assets/blank_profile_picture.png') String imagePath,
    Address? defaultAddress,
    @Default([]) List<CreditCard> creditCard,
    @Default([]) List<Address> address,
    @Default([]) List<Order> order,
    @Default([]) List<Transaction> transaction,
  }) = _User;
}
