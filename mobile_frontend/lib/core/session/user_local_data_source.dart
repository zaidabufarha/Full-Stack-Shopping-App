import 'dart:convert';

import 'package:big_cart/features/account/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<bool> isFirstTime();
  Future<Unit> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<Unit> clearCache();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveEmail(String email);
  Future<String?> getSavedEmail();
  Future<void> clearSavedEmail();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  static const _cachedUserKey = 'CACHED_USER';
  static const _authTokenKey = 'AUTH_TOKEN';
  static const _firstTimeKey = 'FIRST_TIME';
  static const _savedEmailKey = 'SAVED_EMAIL';

  @override
  Future<Unit> cacheUser(UserModel user) async {
    await sharedPreferences.setString(_cachedUserKey, jsonEncode(user.toJson()));
    await sharedPreferences.setBool(_firstTimeKey, false);
    return unit;
  }

  @override
  Future<Unit> clearCache() async {
    await sharedPreferences.remove(_cachedUserKey);
    await clearToken();
    return unit;
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = sharedPreferences.getString(_cachedUserKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  @override
  Future<bool> isFirstTime() async {
    return sharedPreferences.getBool(_firstTimeKey) ?? true;
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_authTokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_authTokenKey);
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(_authTokenKey);
  }

  @override
  Future<void> saveEmail(String email) async {
    await sharedPreferences.setString(_savedEmailKey, email);
  }

  @override
  Future<String?> getSavedEmail() async {
    return sharedPreferences.getString(_savedEmailKey);
  }

  @override
  Future<void> clearSavedEmail() async {
    await sharedPreferences.remove(_savedEmailKey);
  }
}
