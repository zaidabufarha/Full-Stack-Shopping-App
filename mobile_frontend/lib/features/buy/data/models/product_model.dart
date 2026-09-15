import 'package:big_cart/core/converter/color_converter.dart';
import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [CategoryConverter(), ReviewConverter(), ColorConverter()],
)
class ProductModel {
  final String id;
  final String name;
  final String imagePath;
  final String amount;
  final String description;
  final double discount;
  final double price;
  final bool isNew;
  final bool isFavorite;
  final bool freeShipping;
  final bool sameDayDelivery;
  final Category category;
  final Color color;
  final List<Review> review;

  ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.amount,
    required this.description,
    required this.discount,
    required this.price,
    required this.isNew,
    this.isFavorite = false,
    this.freeShipping = false,
    this.sameDayDelivery = false,
    required this.category,
    required this.color,
    this.review = const [],
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

  Product toEntity() => Product(
        id: id,
        name: name,
        imagePath: imagePath,
        amount: amount,
        description: description,
        discount: discount,
        price: price,
        isNew: isNew,
        isFavorite: isFavorite,
        freeShipping: freeShipping,
        sameDayDelivery: sameDayDelivery,
        category: category,
        color: color,
        review: review,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
