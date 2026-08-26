import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductList {
  final BuyRepository buyRepository;
  GetProductList(this.buyRepository);
  Future<Either<Failure, List<Product>>> call() async {
    return await buyRepository.getProductList();
  }
}
