import 'package:big_cart/core/converter/color_converter.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(converters: [ColorConverter()])
class CategoryModel extends Category {
  CategoryModel({
    required super.name,
    required super.imagePath,
    required super.color,
  });

  factory CategoryModel.fromEntity(Category entity) => CategoryModel(
        name: entity.name,
        imagePath: entity.imagePath,
        color: entity.color,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('image_path') && !mapped.containsKey('imagePath')) {
      mapped['imagePath'] = mapped['image_path'];
    }
    return _$CategoryModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
