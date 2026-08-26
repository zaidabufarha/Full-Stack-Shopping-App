import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateQuantity {
  final BuyRepository buyRepository;
  UpdateQuantity(this.buyRepository);
  Future<Either<Failure, Unit>> call(CartItem item, int newQuantity) async {
    return await buyRepository.updateQuantity(item, newQuantity);
  }
}
