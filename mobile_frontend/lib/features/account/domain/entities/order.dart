import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

@freezed
abstract class Order with _$Order {
  const factory Order({
    String? id,
    required List<CartItem> orderItem,
    required Address address,
    required CreditCard creditCard,
    required String shippingMethod,
    required DateTime datePlaced,
    DateTime? dateConfirmed,
    DateTime? dateDelivered,
    DateTime? dateOutForDelivery,
    DateTime? dateShipped,
  }) = _Order;
}
