import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';

class User {
  String name;
  String email;
  String number;
  String password;
  String imagePath;
  Address? defaultAddress;
  List<CreditCard> creditCardList;
  List<Address> addressList;
  List<Order> orderList;
  List<Transaction> transactionList;
  User({
    required this.name,
    required this.email,
    required this.number,
    required this.password,
    this.imagePath = 'assets/blank_profile_picture.png',
    this.defaultAddress,
    this.creditCardList = const [],
    this.addressList = const [],
    this.orderList = const [],
    this.transactionList = const [],
  });
}
