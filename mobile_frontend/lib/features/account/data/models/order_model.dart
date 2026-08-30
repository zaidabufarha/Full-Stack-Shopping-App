import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [CartItemConverter(), AddressConverter(), CreditCardConverter()],
)
class OrderModel extends Order {
  OrderModel({
    super.id,
    super.orderItem = const [],
    required super.datePlaced,
    required super.address,
    required super.creditCard,
    required super.shippingMethod,
  });

  factory OrderModel.fromEntity(Order entity) => OrderModel(
        id: entity.id,
        orderItem: entity.orderItem,
        datePlaced: entity.datePlaced,
        address: entity.address,
        creditCard: entity.creditCard,
        shippingMethod: entity.shippingMethod,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
