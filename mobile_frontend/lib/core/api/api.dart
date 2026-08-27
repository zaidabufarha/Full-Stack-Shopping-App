import 'package:big_cart/core/di/injection.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiConsumer {
  Future<dynamic> graphql({
    required String query,
    Map<String, dynamic>? variables,
  });

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> patch({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> delete({required String path});
}

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio});

  @override
  Future<dynamic> graphql({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    try {
      final response = await dio.post(
        '/graphql',
        data: {
          'query': query,
          'variables': ?variables,
        },
      );
      final data = response.data;
      if (data is Map &&
          data.containsKey('errors') &&
          (data['errors'] as List).isNotEmpty) {
        final message =
            data['errors'][0]['message']?.toString() ?? 'GraphQL error';
        final lower = message.toLowerCase();
        if (lower.contains('not authorized') ||
            lower.contains('jwt') ||
            lower.contains('expired')) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('AUTH_TOKEN');
          await prefs.remove('CACHED_USER');
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const WelcomePage()),
            (route) => false,
          );
        }
        throw Exception(message);
      }
      return data is Map && data.containsKey('data') ? data['data'] : data;
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['errors'] != null) {
        final errors = e.response!.data['errors'] as List;
        if (errors.isNotEmpty) {
          final message = errors[0]['message']?.toString() ?? 'GraphQL error';
          throw Exception(message);
        }
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> delete({required String path}) async {
    final response = await dio.delete(path);
    return response;
  }

  @override
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(path, queryParameters: queryParameters);
    return response;
  }

  @override
  Future<dynamic> patch({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.patch(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response;
  }

  @override
  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response;
  }

  //put is like post but at a specific lcation
  @override
  Future<dynamic> put({
    required String path,
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.put(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response;
  }
}
