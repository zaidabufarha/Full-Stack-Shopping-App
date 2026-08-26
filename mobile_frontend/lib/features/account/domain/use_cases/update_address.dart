import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateAddress {
  final AccountRepository accountRepository;
  UpdateAddress({required this.accountRepository});

  Future<Either<Failure, Unit>> call(Address address) async {
    return await accountRepository.updateAddress(address);
  }
}
