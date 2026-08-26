import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource extends UserLocalDataSource {}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends UserLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required super.sharedPreferences});
}
