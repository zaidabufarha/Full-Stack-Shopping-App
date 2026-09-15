import 'package:big_cart/core/converter/color_converter.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [ColorConverter()],
)
class CategoryModel {
  final String name;
  final String imagePath;
  final Color color;

  CategoryModel({
    required this.name,
    required this.imagePath,
    required this.color,
  });

  factory CategoryModel.fromEntity(Category entity) => CategoryModel(
        name: entity.name,
        imagePath: entity.imagePath,
        color: entity.color,
      );

  Category toEntity() => Category(
        name: name,
        imagePath: imagePath,
        color: color,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
