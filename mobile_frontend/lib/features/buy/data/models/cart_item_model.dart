import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [ProductConverter()],
)
class CartItemModel extends CartItem {
  CartItemModel(super.product, super.quantity);

  factory CartItemModel.fromEntity(CartItem entity) => CartItemModel(
        entity.product,
        entity.quantity,
      );

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
