import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/core/network/network_info.dart';
import 'package:big_cart/features/account/data/data_sources/account_remote_data_source.dart';
import 'package:big_cart/features/account/data/models/address_model.dart';
import 'package:big_cart/features/account/data/models/credit_card_model.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;
  final NetworkInfo networkInfo;
  AccountRepositoryImpl({
    required this.accountRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addAddress({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  }) async {
    try {
      await accountRemoteDataSource.addAddress(
        name: name,
        address: address,
        city: city,
        zip: zip,
        country: country,
        phoneNumber: phoneNumber,
        makeDefault: makeDefault,
      );
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required bool saveCard,
    required PaymentProcessor processor,
  }) async {
    try {
      await accountRemoteDataSource.addCreditCard(
        name: name,
        cardNumber: cardNumber,
        expiration: expiration,
        saveCard: saveCard,
        processor: processor,
      );
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProfilePicture({
    required String path,
  }) async {
    try {
      await accountRemoteDataSource.addProfilePicture(path: path);
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    try {
      final response = await accountRemoteDataSource.getAddresses();
      return Right(response);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<CreditCard>>> getCreditCards() async {
    try {
      final response = await accountRemoteDataSource.getCreditCards();
      return Right(response);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, NotificationPreferences>>
  getNotificationPreferences() async {
    try {
      final response = await accountRemoteDataSource
          .getNotificationPreferences();
      return Right(response);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      final response = await accountRemoteDataSource.getOrders();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    try {
      final response = await accountRemoteDataSource.getTransactions();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, User>> getUserData() async {
    try {
      final response = await accountRemoteDataSource.getUserData();
      return Right(response);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> setNotificationPreferences({
    required bool allowNotifications,
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  }) async {
    try {
      await accountRemoteDataSource.setNotificationPreferences(
        allowEmailNotifications: allowEmailNotifications,
        allowOrderNotifications: allowOrderNotifications,
        allowGeneralNotifications: allowGeneralNotifications,
      );
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(Address address) async {
    try {
      final addressModel = AddressModel(
        id: address.id,
        name: address.name,
        street: address.street,
        city: address.city,
        country: address.country,
        phone: address.phone,
        zipCode: address.zipCode,
        isDefault: address.isDefault,
      );
      await accountRemoteDataSource.updateAddress(addressModel);
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreditCard(CreditCard card) async {
    try {
      final cardModel = CreditCardModel(
        id: card.id,
        cardHolderName: card.cardHolderName,
        last4: card.last4,
        expiryDate: card.expiryDate,
        stripePaymentId: card.stripePaymentId,
        processor: card.processor,
        isDefault: card.isDefault,
      );
      await accountRemoteDataSource.updateCreditCard(cardModel);
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> setDefaultCreditCard(String cardId) async {
    try {
      await accountRemoteDataSource.setDefaultCreditCard(cardId);
      return Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    try {
      await accountRemoteDataSource.updateProfile(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        currentPassword: currentPassword,
        newPassword1: newPassword1,
        newPassword2: newPassword2,
      );
      return Right(unit);
    } on WrongPasswordException {
      return Left(WrongPasswordFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
