import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtp {
  final AuthRepository repository;
  VerifyOtp({required this.repository});
  Future<Either<Failure, User>> call({
    required String email,
    required String otp,
    required String number,
    required String password,
  }) async {
    return await repository.verifyOtp(
      email: email,
      number: number,
      password: password,
      otp: otp,
    );
  }
}
