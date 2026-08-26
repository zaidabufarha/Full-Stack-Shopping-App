import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetNotificationPreferences {
  final AccountRepository accountRepository;
  SetNotificationPreferences({required this.accountRepository});

  Future<Either<Failure, Unit>> call({
    required bool allowNotifications,
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  }) async {
    return await accountRepository.setNotificationPreferences(
      allowNotifications: allowNotifications,
      allowEmailNotifications: allowEmailNotifications,
      allowOrderNotifications: allowOrderNotifications,
      allowGeneralNotifications: allowGeneralNotifications,
    );
  }
}
