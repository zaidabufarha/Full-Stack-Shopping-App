import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddCreditCard {
  final AccountRepository accountRepository;
  AddCreditCard({required this.accountRepository});

  Future<Either<Failure, Unit>> call({
    required String name,
    required String cardNumber,
    required String expiration,
    required bool saveCard,
    required PaymentProcessor processor,
  }) async {
    return await accountRepository.addCreditCard(
      name: name,
      cardNumber: cardNumber,
      expiration: expiration,
      saveCard: saveCard,
      processor: processor,
    );
  }
}
