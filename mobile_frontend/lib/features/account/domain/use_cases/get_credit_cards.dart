import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCreditCards {
  final AccountRepository accountRepository;
  GetCreditCards({required this.accountRepository});

  Future<Either<Failure, List<CreditCard>>> call() async {
    return await accountRepository.getCreditCards();
  }
}
