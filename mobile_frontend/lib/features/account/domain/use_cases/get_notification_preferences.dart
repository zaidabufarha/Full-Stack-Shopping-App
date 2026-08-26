import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNotificationPreferences {
  final AccountRepository accountRepository;
  GetNotificationPreferences({required this.accountRepository});

  Future<Either<Failure, NotificationPreferences>> call() async {
    return await accountRepository.getNotificationPreferences();
  }
}
