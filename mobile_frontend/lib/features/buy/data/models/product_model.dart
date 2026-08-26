import 'package:big_cart/core/converter/color_converter.dart';
import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(
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
    required super.isFavorite,
    required super.category,
    required super.color,
    required super.reviewList,
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
    category: entity.category,
    color: entity.color,
    reviewList: entity.reviewList,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('image_path') && !mapped.containsKey('imagePath')) {
      mapped['imagePath'] = mapped['image_path'];
    }
    if (mapped.containsKey('is_new') && !mapped.containsKey('isNew')) {
      mapped['isNew'] = mapped['is_new'];
    }
    if (mapped.containsKey('is_favorite') && !mapped.containsKey('isFavorite')) {
      mapped['isFavorite'] = mapped['is_favorite'];
    }
    if (mapped.containsKey('review') && !mapped.containsKey('reviewList')) {
      mapped['reviewList'] = mapped['review'];
    }
    if (mapped['reviews'] is Map) {
      mapped['reviewList'] = (mapped['reviews'] as Map).values.toList();
    }
    if (mapped['id'] != null) {
      mapped['id'] = mapped['id'].toString();
    }
    mapped['reviewList'] ??= [];
    mapped['category'] ??= {
      'name': 'Produce',
      'imagePath': 'assets/produce.png',
      'color': '#53B175',
    };
    return _$ProductModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
