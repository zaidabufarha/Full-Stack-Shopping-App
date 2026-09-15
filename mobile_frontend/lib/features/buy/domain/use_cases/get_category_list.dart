import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoryList {
  final BuyRepository buyRepository;
  GetCategoryList(this.buyRepository);
  Future<Either<Failure, List<Category>>> call() async {
    return await buyRepository.getCategoryList();
  }
}
