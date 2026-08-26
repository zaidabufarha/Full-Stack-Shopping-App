import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;

@lazySingleton
class GetOrders {
  final AccountRepository accountRepository;
  GetOrders({required this.accountRepository});

  Future<Either<Failure, List<Order>>> call() async {
    return await accountRepository.getOrders();
  }
}
