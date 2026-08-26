import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfile {
  final AccountRepository accountRepository;
  UpdateProfile({required this.accountRepository});

  Future<Either<Failure, Unit>> call({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    if (newPassword1 != newPassword2) {
      //no repo needed for this
      return Left(PasswordMismatchFailure());
    }
    return await accountRepository.updateProfile(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      currentPassword: currentPassword,
      newPassword1: newPassword1,
      newPassword2: newPassword2,
    );
  }
}
