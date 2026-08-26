import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddReview {
  final BuyRepository buyRepository;
  AddReview(this.buyRepository);
  Future<Either<Failure, Unit>> call(String id, Review review) async {
    return await buyRepository.addReview(id, review);
  }
}
