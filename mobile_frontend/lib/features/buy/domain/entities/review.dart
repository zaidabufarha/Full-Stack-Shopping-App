import 'package:big_cart/features/account/domain/entities/user.dart';

class Review {
  User user;
  DateTime createdAt;
  double rating;
  String comment;

  Review({
    required this.user,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });
}
