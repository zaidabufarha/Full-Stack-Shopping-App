import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';

@freezed
abstract class Review with _$Review {
  const factory Review({
    required User user,
    required String comment,
    required double rating,
    required DateTime createdAt,
  }) = _Review;
}
