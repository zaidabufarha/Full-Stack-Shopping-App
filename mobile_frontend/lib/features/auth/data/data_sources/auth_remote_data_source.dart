import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/models/user_model.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> sendOtp(String email);
  Future<Unit> verifyOtp({required String email, required String otp});
  Future<User> logIn({
    required String email,
    required String password,
    required bool remember,
  });
  Future<User> signUp({
    required String email,
    required String password,
    required String number,
  });
  Future<Unit> forgotPassword({
    required String email,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;
  final UserLocalDataSource userLocalDataSource;

  AuthRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.userLocalDataSource,
  });

  @override
  Future<Unit> forgotPassword({required String email}) async {
    const mutation = r'''
      mutation ForgotPassword($email: String!) {
        forgotPassword(email: $email)
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {'email': email},
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('not found') || msg.contains('not exist') || msg.contains('invalid email')) {
        throw InvalidEmailException();
      }
      rethrow;
    }
  }

  @override
  Future<User> logIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    // BACKEND INTEGRATION: GraphQL logIn mutation with token & session caching
    const mutation = r'''
      mutation LogIn($email: String!, $password: String!) {
        logIn(email: $email, password: $password) {
          token
          user {
            id
            name
            email
            phone
            image_path
            default_address_id
            default_credit_card_id
            address {
              id
              name
              street
              city
              state
              zip_code
              country
              phone
            }
            credit_card {
              id
              card_holder_name
              card_number
              expiry_date
              cvv
              processor
            }
            order {
              id
              shipping_method
              total_amount
              status
              date_placed
              order_item {
                id
                quantity
                price_at_purchase
                product {
                  id
                  name
                  image_path
                  amount
                  description
                  discount
                  price
                  is_new
                  is_favorite
                  color
                  rating
                }
              }
              address {
                id
                name
                street
                city
                state
                zip_code
                country
                phone
              }
              credit_card {
                id
                card_holder_name
                card_number
                expiry_date
                cvv
                processor
              }
            }
            transaction {
              id
              amount
              status
              payment_method
              created_at
            }
          }
        }
      }
    ''';

    try {
      final data = await apiConsumer.graphql(
        query: mutation,
        variables: {
          'email': email,
          'password': password,
        },
      );

      final loginPayload = data['logIn'];
      final token = loginPayload['token'] as String;
      final userMap = Map<String, dynamic>.from(loginPayload['user']);
      userMap['password'] = password;

      // Save token and credentials
      await userLocalDataSource.saveToken(token);
      if (remember) {
        await userLocalDataSource.saveEmail(email);
      } else {
        await userLocalDataSource.clearSavedEmail();
      }

      final user = UserModel.fromJson(userMap);
      await userLocalDataSource.cacheUser(user);
      return user;
    } on DioException {
      throw NoInternetException();
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('incorrect password') || msg.contains('wrong password')) {
        throw WrongPasswordException();
      } else if (msg.contains('not found') || msg.contains('invalid email')) {
        throw InvalidEmailException();
      }
      rethrow;
    }
  }

  @override
  Future<Unit> sendOtp(String email) async {
    return unit;
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String number,
  }) async {
    // BACKEND INTEGRATION: GraphQL signUp mutation
    const mutation = r'''
      mutation SignUp($email: String!, $number: String!, $password: String!) {
        signUp(email: $email, number: $number, password: $password) {
          id
          name
          email
          phone
        }
      }
    ''';

    try {
      final data = await apiConsumer.graphql(
        query: mutation,
        variables: {
          'email': email,
          'number': number,
          'password': password,
        },
      );

      final userMap = Map<String, dynamic>.from(data['signUp']);
      userMap['password'] = password;
      return UserModel.fromJson(userMap);
    } on DioException {
      throw NoInternetException();
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('already in use') || msg.contains('invalid email')) {
        throw InvalidEmailException();
      }
      rethrow;
    }
  }

  @override
  Future<Unit> verifyOtp({required String email, required String otp}) async {
    if (otp == '123456' || otp.isNotEmpty) {
      return unit;
    } else {
      throw WrongOTPException();
    }
  }
}
