import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';

class User {
  String name;
  String email;
  String phone;
  String password;
  String imagePath;
  Address? defaultAddress;
  List<CreditCard> creditCard;
  List<Address> address;
  List<Order> order;
  List<Transaction> transaction;

  User({
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
}
