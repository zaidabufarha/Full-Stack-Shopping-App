import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [UserConverter()],
)
class ReviewModel {
  final User user;
  final String comment;
  final double rating;
  final DateTime createdAt;

  ReviewModel({
    required this.user,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewModel.fromEntity(Review entity) => ReviewModel(
        user: entity.user,
        comment: entity.comment,
        rating: entity.rating,
        createdAt: entity.createdAt,
      );

  Review toEntity() => Review(
        user: user,
        comment: comment,
        rating: rating,
        createdAt: createdAt,
      );

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
