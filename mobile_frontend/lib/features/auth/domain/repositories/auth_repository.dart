import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String number,
  });
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
    required bool remember,
  });

  Future<Either<Failure, Unit>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, Unit>> sendOtp({required String number});

  Future<Either<Failure, User>> verifyOtp({
    required String email,
    required String number,
    required String password,
    required String otp,
  });

  Future<bool> isFirstTime();
  Future<String?> getToken();
  Future<void> clearCache();
  Future<void> saveEmail(String email);
  Future<String?> getSavedEmail();
  Future<void> clearSavedEmail();
}
