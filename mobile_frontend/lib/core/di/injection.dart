import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection.config.dart';

import 'package:flutter/material.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';

//navigatorkey can push pages without buildcontext. works for network intercepts to kick unauthorized users with expired tokens
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio(SharedPreferences prefs) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:4321', // change to render
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = prefs.getString('AUTH_TOKEN');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          final statusCode = error.response?.statusCode;
          final errorData = error.response?.data;
          bool isUnauthorized = statusCode == 401;
          if (errorData is Map && errorData['errors'] is List) {
            final msg =
                errorData['errors'][0]?['message']?.toString().toLowerCase() ??
                '';
            if (msg.contains('not authorized') ||
                msg.contains('jwt') ||
                msg.contains('expired')) {
              isUnauthorized = true;
            }
          }
          if (isUnauthorized) {
            await prefs.remove('AUTH_TOKEN');
            await prefs.remove('CACHED_USER');
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const WelcomePage()),
              (route) => false,
            );
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.instance;

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
