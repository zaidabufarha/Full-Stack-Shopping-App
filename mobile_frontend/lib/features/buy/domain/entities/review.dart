import 'package:big_cart/features/account/domain/entities/user.dart';

class Review {
  User user;
  DateTime timestamp;
  double rating;
  String content;
  Review({
    required this.user,
    required this.content,
    required this.rating,
    required this.timestamp,
  });
}
