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
      User newUser = User(
        name: 'User',
        email: email,
        number: number,
        password: password,
      );
      return Right(newUser);
    } on WrongOTPException {
      return Left(WrongOTPFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<void> cacheUser(User user) async {
    final userModel = UserModel(
      name: user.name,
      email: user.email,
      number: user.number,
      password: user.password,
    );
    await authLocalDataSource.cacheUser(userModel);
  }

  @override
  Future<void> clearCache() async {
    await authLocalDataSource.clearCache();
  }

  @override
  Future<User?> getCachedUser() async {
    UserModel? userModel = await authLocalDataSource.getCachedUser();
    return userModel;
  }

  @override
  Future<bool> isFirstTime() async {
    return await authLocalDataSource.isFirstTime();
  }

  @override
  Future<void> saveCredentials(String email, String password) async {
    await authLocalDataSource.saveCredentials(email, password);
  }

  @override
  Future<Map<String, String>?> getSavedCredentials() async {
    return await authLocalDataSource.getSavedCredentials();
  }

  @override
  Future<void> clearCredentials() async {
    await authLocalDataSource.clearCredentials();
  }
}
