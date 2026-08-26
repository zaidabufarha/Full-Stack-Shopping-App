import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:dartz/dartz.dart' hide Order; //dartz has an Order in it

abstract class AccountRepository {
  Future<Either<Failure, Unit>> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  });

  Future<Either<Failure, Unit>> addCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required String cvv,
    required bool saveCard,
    required paymentProccessor proccessor,
  });
  Future<Either<Failure, Unit>> updateCreditCard(CreditCard card);

  Future<Either<Failure, List<CreditCard>>> getCreditCards();

  Future<Either<Failure, Unit>> addProfilePicture({required String path});
  Future<Either<Failure, User>> getUserData();

  Future<Either<Failure, Unit>> addAddress({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  });
  Future<Either<Failure, Unit>> updateAddress(Address address);

  Future<Either<Failure, List<Address>>> getAddresses();

  Future<Either<Failure, Unit>> setNotificationPreferences({
    required bool allowNotifications,
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  });

  Future<Either<Failure, NotificationPreferences>> getNotificationPreferences();

  Future<Either<Failure, List<Order>>> getOrders();
  Future<Either<Failure, List<Transaction>>> getTransactions();
}
