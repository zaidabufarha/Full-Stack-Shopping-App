import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateCreditCard {
  final AccountRepository accountRepository;
  UpdateCreditCard({required this.accountRepository});

  Future<Either<Failure, Unit>> call(CreditCard card) async {
    return await accountRepository.updateCreditCard(card);
  }
}
