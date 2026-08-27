import 'package:big_cart/core/converter/color_converter.dart';
import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [CategoryConverter(), ReviewConverter(), ColorConverter()],
)
class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.imagePath,
    required super.amount,
    required super.description,
    required super.discount,
    required super.price,
    required super.isNew,
    super.isFavorite = false,
    super.freeShipping = false,
    super.sameDayDelivery = false,
    required super.category,
    required super.color,
    super.review = const [],
  });

  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        imagePath: entity.imagePath,
        amount: entity.amount,
        description: entity.description,
        discount: entity.discount,
        price: entity.price,
        isNew: entity.isNew,
        isFavorite: entity.isFavorite,
        freeShipping: entity.freeShipping,
        sameDayDelivery: entity.sameDayDelivery,
        category: entity.category,
        color: entity.color,
        review: entity.review,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
