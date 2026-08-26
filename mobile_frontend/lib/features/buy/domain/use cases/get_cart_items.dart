import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCartItems {
  final BuyRepository buyRepository;
  GetCartItems(this.buyRepository);
  Future<Either<Failure, List<CartItem>>> call({
    bool isFavorites = false,
  }) async {
    return await buyRepository.getCartItems(isFavorites: isFavorites);
  }
}
