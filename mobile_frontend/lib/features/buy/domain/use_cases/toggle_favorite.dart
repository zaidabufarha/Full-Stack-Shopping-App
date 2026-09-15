import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleFavorite {
  final BuyRepository buyRepository;
  ToggleFavorite(this.buyRepository);
  Future<Either<Failure, Unit>> call(String id, bool isFavorite) async {
    return await buyRepository.toggleFavorite(id, isFavorite);
  }
}
