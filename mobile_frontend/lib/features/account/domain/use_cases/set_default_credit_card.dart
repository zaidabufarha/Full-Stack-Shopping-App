import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetDefaultCreditCard {
  final AccountRepository accountRepository;
  SetDefaultCreditCard({required this.accountRepository});

  Future<Either<Failure, Unit>> call(String cardId) async {
    return await accountRepository.setDefaultCreditCard(cardId);
  }
}
