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
  Future<void> saveCredentials(String email, String password);
  Future<Map<String, String>?> getSavedCredentials();
  Future<void> clearCredentials();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheUser(UserModel user) async {
    final json = user.toJson();
    await sharedPreferences.setString('CACHED_USER', jsonEncode(json));
    await sharedPreferences.setBool('FIRST_TIME', false);
    return unit;
  }

  @override
  Future<Unit> clearCache() async {
    await sharedPreferences.remove('CACHED_USER');
    await clearToken();
    return unit;
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = sharedPreferences.getString('CACHED_USER');
    if (userJson == null) {
      return null;
    } else {
      final map = jsonDecode(userJson);
      return UserModel.fromJson(map);
    }
  }

  @override
  Future<bool> isFirstTime() async {
    final response = sharedPreferences.getBool('FIRST_TIME');
    if (response == null) {
      return true;
    } else {
      return response;
    }
  }

  Future<void> saveSavedCredentials(String email, String password) async {
    await sharedPreferences.setString('SAVED_EMAIL', email);
    await sharedPreferences.setString('SAVED_PASSWORD', password);
  }

  @override
  Future<void> clearCredentials() async {
    await sharedPreferences.remove('SAVED_EMAIL');
    await sharedPreferences.remove('SAVED_PASSWORD');
  }

  @override
  Future<Map<String, String>?> getSavedCredentials() async {
    final email = sharedPreferences.getString('SAVED_EMAIL');
    final password = sharedPreferences.getString('SAVED_PASSWORD');
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  @override
  Future<void> saveCredentials(String email, String password) async {
    await sharedPreferences.setString('SAVED_EMAIL', email);
    await sharedPreferences.setString('SAVED_PASSWORD', password);
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('AUTH_TOKEN', token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('AUTH_TOKEN');
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove('AUTH_TOKEN');
  }
}
