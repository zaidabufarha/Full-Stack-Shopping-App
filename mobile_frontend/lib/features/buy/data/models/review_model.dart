import 'package:big_cart/core/converter/entity_converters.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable(converters: [UserConverter()])
class ReviewModel extends Review {
  ReviewModel({
    required super.user,
    required super.content,
    required super.rating,
    required super.timestamp,
  });

  factory ReviewModel.fromEntity(Review entity) => ReviewModel(
        user: entity.user,
        content: entity.content,
        rating: entity.rating,
        timestamp: entity.timestamp,
      );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    // BACKEND INTEGRATION: Support GraphQL field mapping
    final mapped = Map<String, dynamic>.from(json);
    if (mapped.containsKey('comment') && !mapped.containsKey('content')) {
      mapped['content'] = mapped['comment'];
    }
    if (mapped.containsKey('created_at') && !mapped.containsKey('timestamp')) {
      mapped['timestamp'] = mapped['created_at'];
    }
    if (mapped['user'] == null) {
      mapped['user'] = {
        'name': 'User',
        'email': '',
        'number': '',
        'password': '',
      };
    }
    return _$ReviewModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
