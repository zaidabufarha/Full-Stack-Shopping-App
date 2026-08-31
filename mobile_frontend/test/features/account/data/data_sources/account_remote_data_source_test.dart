import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/data_sources/account_remote_data_source.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiConsumer extends Mock implements ApiConsumer {}
class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late MockApiConsumer mockApiConsumer;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late AccountRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    mockUserLocalDataSource = MockUserLocalDataSource();
    dataSource = AccountRemoteDataSourceImpl(
      apiConsumer: mockApiConsumer,
      userLocalDataSource: mockUserLocalDataSource,
    );
  });

  group('AccountRemoteDataSourceImpl JSON Deserialization', () {
    test('getTransactions parses transaction list with amounts and payment methods', () async {
      final mockResponse = {
        'me': {
          'transaction': [
            {
              'id': '1',
              'amount': 25.50,
              'status': 'success',
              'payment_method': 'visa',
              'created_at': '2026-08-30T17:00:00.000Z',
            },
            {
              'id': '2',
              'amount': 100.0,
              'status': 'success',
              'payment_method': 'mastercard',
              'created_at': '2026-08-29T12:00:00.000Z',
            },
          ]
        }
      };

      when(() => mockApiConsumer.graphql(query: any(named: 'query')))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getTransactions();

      expect(result.length, 2);
      expect(result[0].amount, 25.50);
      expect(result[0].paymentMethod, PaymentProcessor.visa);
      expect(result[1].amount, 100.0);
      expect(result[1].paymentMethod, PaymentProcessor.mastercard);
    });

    test('getAddresses parses addresses list', () async {
      final mockResponse = {
        'me': {
          'default_address_id': '1',
          'address': [
            {
              'id': '1',
              'name': 'Home',
              'street': '123 Main St',
              'city': 'Amman',
              'zip_code': '11181',
              'country': 'Jordan',
              'phone': '0790000000',
            }
          ]
        }
      };

      when(() => mockApiConsumer.graphql(query: any(named: 'query')))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getAddresses();

      expect(result.length, 1);
      expect(result.first.name, 'Home');
      expect(result.first.isDefault, true);
    });

    test('getUserData parses profile data properly', () async {
      final mockResponse = {
        'me': {
          'id': '1',
          'name': 'Zaid',
          'email': 'zaid@example.com',
          'phone': '0790000000',
          'image_path': 'assets/blank_profile_picture.png',
        }
      };

      when(() => mockApiConsumer.graphql(query: any(named: 'query')))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getUserData();

      expect(result.name, 'Zaid');
      expect(result.email, 'zaid@example.com');
    });
  });
}
