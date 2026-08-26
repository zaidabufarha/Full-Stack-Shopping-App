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
    required String cvv,
    required bool saveCard,
    required paymentProccessor proccessor,
  }) async {
    return await accountRepository.addCreditCard(
      name: name,
      cardNumber: cardNumber,
      expiration: expiration,
      cvv: cvv,
      saveCard: saveCard,
      proccessor: proccessor,
    );
  }
}
