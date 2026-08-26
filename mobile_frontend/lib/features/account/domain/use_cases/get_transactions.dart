import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTransactions {
  final AccountRepository accountRepository;
  GetTransactions({required this.accountRepository});

  Future<Either<Failure, List<Transaction>>> call() async {
    return await accountRepository.getTransactions();
  }
}
