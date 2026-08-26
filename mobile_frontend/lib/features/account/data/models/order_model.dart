import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(
  converters: [CartItemConverter(), AddressConverter(), CreditCardConverter()],
)
class OrderModel extends Order {
  OrderModel({
    super.id,
    required super.productList,
    required super.datePlaced,
    required super.shippingAddress,
    required super.creditCard,
    required super.shippingMethod,
  });

  factory OrderModel.fromEntity(Order entity) => OrderModel(
    id: entity.id,
    productList: entity.productList,
    datePlaced: entity.datePlaced,
    shippingAddress: entity.shippingAddress,
    creditCard: entity.creditCard,
    shippingMethod: entity.shippingMethod,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('shipping_method') &&
        !mapped.containsKey('shippingMethod')) {
      mapped['shippingMethod'] = mapped['shipping_method'];
    }
    if (mapped.containsKey('date_placed') &&
        !mapped.containsKey('datePlaced')) {
      mapped['datePlaced'] = mapped['date_placed'];
    }
    if (mapped.containsKey('address') &&
        !mapped.containsKey('shippingAddress')) {
      mapped['shippingAddress'] = mapped['address'];
    }
    if (mapped.containsKey('credit_card') &&
        !mapped.containsKey('creditCard')) {
      mapped['creditCard'] = mapped['credit_card'];
    }
    if (mapped.containsKey('order_item') &&
        !mapped.containsKey('productList')) {
      mapped['productList'] = (mapped['order_item'] as List).map((item) {
        return {
          'product': item['product'],
          'quantity': item['quantity'],
        };
      }).toList();
    }
    if (mapped['id'] != null) {
      mapped['id'] = mapped['id'].toString();
    }
    mapped['productList'] ??= [];

    return _$OrderModelFromJson(mapped);
  }
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
