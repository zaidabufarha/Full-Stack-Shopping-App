import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;

@lazySingleton
class CheckOut {
  final BuyRepository buyRepository;
  CheckOut(this.buyRepository);
  Future<Either<Failure, Unit>> call(Order order) async {
    return await buyRepository.checkOut(order);
  }
}
