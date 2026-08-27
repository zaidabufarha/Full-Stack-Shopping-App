import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [UserConverter()],
)
class ReviewModel extends Review {
  ReviewModel({
    required super.user,
    required super.comment,
    required super.rating,
    required super.createdAt,
  });

  factory ReviewModel.fromEntity(Review entity) => ReviewModel(
        user: entity.user,
        comment: entity.comment,
        rating: entity.rating,
        createdAt: entity.createdAt,
      );

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
