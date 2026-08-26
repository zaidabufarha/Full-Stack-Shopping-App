import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';

class Order {
  int? id;
  List<CartItem> productList;
  DateTime datePlaced;
  Address shippingAddress;
  CreditCard creditCard;
  String shippingMethod;
  DateTime? dateConfirmed;
  DateTime? dateShipped;
  DateTime? dateOutForDelivery;
  DateTime? dateDelivered;

  Order({
    this.id,
    required this.productList,
    required this.datePlaced,
    required this.shippingAddress,
    required this.creditCard,
    required this.shippingMethod,
    this.dateConfirmed,
    this.dateDelivered,
    this.dateOutForDelivery,
    this.dateShipped,
  });
}
