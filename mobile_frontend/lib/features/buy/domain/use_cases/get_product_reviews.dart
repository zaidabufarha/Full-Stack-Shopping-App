import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductReviews {
  final BuyRepository buyRepository;
  GetProductReviews(this.buyRepository);
  Future<Either<Failure, List<Review>>> call(String id) async {
    return await buyRepository.getProductReviews(id);
  }
}
