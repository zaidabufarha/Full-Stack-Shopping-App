import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAddresses {
  final AccountRepository accountRepository;
  GetAddresses({required this.accountRepository});

  Future<Either<Failure, List<Address>>> call() async {
    return await accountRepository.getAddresses();
  }
}
