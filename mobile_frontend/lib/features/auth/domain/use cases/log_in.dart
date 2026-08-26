import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogIn {
  final AuthRepository authRepository;
  LogIn({required this.authRepository});
  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required bool remember,
  }) async {
    return await authRepository.logIn(
      email: email,
      password: password,
      remember: remember,
    );
  }
}
