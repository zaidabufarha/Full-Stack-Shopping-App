import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';

class Order {
  String? id;
  List<CartItem> orderItem;
  Address address;
  CreditCard creditCard;
  String shippingMethod;
  DateTime createdAt;
  DateTime? dateConfirmed;
  DateTime? dateShipped;
  DateTime? dateOutForDelivery;
  DateTime? dateDelivered;

  Order({
    this.id,
    required this.orderItem,
    required this.address,
    required this.creditCard,
    required this.shippingMethod,
    required this.createdAt,
    this.dateConfirmed,
    this.dateDelivered,
    this.dateOutForDelivery,
    this.dateShipped,
  });
}
