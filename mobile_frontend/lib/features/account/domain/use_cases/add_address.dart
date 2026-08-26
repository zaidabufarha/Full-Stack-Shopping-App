import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddAddress {
  final AccountRepository accountRepository;
  AddAddress({required this.accountRepository});

  Future<Either<Failure, Unit>> call({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  }) async {
    return await accountRepository.addAddress(
      name: name,
      address: address,
      city: city,
      zip: zip,
      country: country,
      phoneNumber: phoneNumber,
      makeDefault: makeDefault,
    );
  }
}
