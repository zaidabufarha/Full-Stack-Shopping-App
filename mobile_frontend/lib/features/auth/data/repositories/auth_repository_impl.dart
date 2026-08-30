import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/core/network/network_info.dart';
import 'package:big_cart/features/account/data/models/user_model.dart';
import 'package:big_cart/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:big_cart/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> forgotPassword({
    required String email,
  }) async {
    try {
      await authRemoteDataSource.forgotPassword(email: email);
      return Right(unit);
    } on InvalidEmailException {
      return Left(InvalidEmailFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    try {
      User user = await authRemoteDataSource.logIn(
        email: email,
        password: password,
        remember: remember,
      );
      return Right(user);
    } on InvalidEmailException {
      return Left(InvalidEmailFailure());
    } on WrongPasswordException {
      return Left(WrongPasswordFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendOtp({required String number}) async {
    try {
      await authRemoteDataSource.sendOtp(number);
      return Right(unit);
    } on InvalidEmailException {
      return Left(InvalidEmailFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String number,
  }) async {
    try {
      User user = await authRemoteDataSource.signUp(
        email: email,
        password: password,
        number: number,
      );
      return Right(user);
    } on InvalidEmailException {
      return Left(InvalidEmailFailure());
    } on InvalidNumberException {
      return Left(InvalidNumberFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String email,
    required String number,
    required String password,
    required String otp,
  }) async {
    try {
      await authRemoteDataSource.verifyOtp(email: email, otp: otp);
      final user = await authRemoteDataSource.signUp(
        email: email,
        password: password,
        number: number,
      );
      return Right(user);
    } on WrongOTPException {
      return Left(WrongOTPFailure());
    } on InvalidEmailException {
      return Left(InvalidEmailFailure());
    } on InvalidNumberException {
      return Left(InvalidNumberFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<void> clearCache() async {
    await authLocalDataSource.clearCache();
  }

  @override
  Future<String?> getToken() async {
    return await authLocalDataSource.getToken();
  }

  @override
  Future<bool> isFirstTime() async {
    return await authLocalDataSource.isFirstTime();
  }

  @override
  Future<void> saveEmail(String email) async {
    await authLocalDataSource.saveEmail(email);
  }

  @override
  Future<String?> getSavedEmail() async {
    return await authLocalDataSource.getSavedEmail();
  }

  @override
  Future<void> clearSavedEmail() async {
    await authLocalDataSource.clearSavedEmail();
  }
}
