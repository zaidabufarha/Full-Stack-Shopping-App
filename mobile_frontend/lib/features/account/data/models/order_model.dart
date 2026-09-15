import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [CartItemConverter(), AddressConverter(), CreditCardConverter()],
)
class OrderModel {
  final String? id;
  final List<CartItem> orderItem;
  final Address address;
  final CreditCard creditCard;
  final String shippingMethod;
  final DateTime datePlaced;
  final DateTime? dateConfirmed;
  final DateTime? dateShipped;
  final DateTime? dateOutForDelivery;
  final DateTime? dateDelivered;

  OrderModel({
    this.id,
    this.orderItem = const [],
    required this.datePlaced,
    required this.address,
    required this.creditCard,
    required this.shippingMethod,
    this.dateConfirmed,
    this.dateShipped,
    this.dateOutForDelivery,
    this.dateDelivered,
  });

  factory OrderModel.fromEntity(Order entity) => OrderModel(
        id: entity.id,
        orderItem: entity.orderItem,
        datePlaced: entity.datePlaced,
        address: entity.address,
        creditCard: entity.creditCard,
        shippingMethod: entity.shippingMethod,
        dateConfirmed: entity.dateConfirmed,
        dateShipped: entity.dateShipped,
        dateOutForDelivery: entity.dateOutForDelivery,
        dateDelivered: entity.dateDelivered,
      );

  Order toEntity() => Order(
        id: id,
        orderItem: orderItem,
        address: address,
        creditCard: creditCard,
        shippingMethod: shippingMethod,
        datePlaced: datePlaced,
        dateConfirmed: dateConfirmed,
        dateShipped: dateShipped,
        dateOutForDelivery: dateOutForDelivery,
        dateDelivered: dateDelivered,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
