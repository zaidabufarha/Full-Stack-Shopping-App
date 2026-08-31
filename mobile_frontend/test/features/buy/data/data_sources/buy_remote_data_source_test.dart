import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/buy/data/data_sources/buy_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiConsumer extends Mock implements ApiConsumer {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late MockApiConsumer mockApiConsumer;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late BuyRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    mockUserLocalDataSource = MockUserLocalDataSource();
    dataSource = BuyRemoteDataSourceImpl(
      apiConsumer: mockApiConsumer,
      userLocalDataSource: mockUserLocalDataSource,
    );
  });

  group('BuyRemoteDataSourceImpl JSON Deserialization', () {
    test(
      'getProductList parses products with nested reviews and users without throwing',
      () async {
        final mockResponse = {
          'products': [
            {
              'id': '1',
              'name': 'Fresh Organic Broccoli',
              'image_path': 'assets/broccoli.png',
              'amount': '1 kg',
              'description': 'Fresh broccoli',
              'discount': 0.0,
              'price': 4.99,
              'is_new': true,
              'is_favorite': false,
              'color': '0xFFE6F2EA',
              'rating': 4.5,
              'free_shipping': true,
              'same_day_delivery': false,
              'category': {
                'id': '1',
                'name': 'Vegetables',
                'image_path': 'assets/vegetables.png',
                'color': '0xFFE6F2EA',
              },
              'review': [
                {
                  'id': '10',
                  'rating': 4.5,
                  'comment': 'Very fresh!',
                  'created_at': '2026-08-30T14:00:00.000Z',
                  'user': {
                    'name': 'Zaid',
                    'email': 'zaid@example.com',
                    'phone': '123456789',
                    'image_path': 'assets/blank_profile_picture.png',
                  },
                },
              ],
            },
          ],
        };

        when(
          () => mockApiConsumer.graphql(query: any(named: 'query')),
        ).thenAnswer((_) async => mockResponse);

        final result = await dataSource.getProductList();

        expect(result.length, 1);
        expect(result.first.name, 'Fresh Organic Broccoli');
        expect(result.first.review.length, 1);
        expect(result.first.review.first.user.name, 'Zaid');
        expect(result.first.review.first.user.email, 'zaid@example.com');
        expect(result.first.review.first.rating, 4.5);
      },
    );

    test('getProductReviews parses reviews with user data', () async {
      final mockResponse = {
        'productReviews': [
          {
            'id': '101',
            'rating': 5.0,
            'comment': 'Excellent quality!',
            'created_at': '2026-08-30T10:00:00.000Z',
            'user': {
              'name': 'John Doe',
              'email': 'john@example.com',
              'phone': '987654321',
              'image_path': 'assets/blank_profile_picture.png',
            },
          },
        ],
      };

      when(
        () => mockApiConsumer.graphql(
          query: any(named: 'query'),
          variables: any(named: 'variables'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getProductReviews('1');

      expect(result.length, 1);
      expect(result.first.comment, 'Excellent quality!');
      expect(result.first.rating, 5.0);
      expect(result.first.user.name, 'John Doe');
      expect(result.first.user.email, 'john@example.com');
    });

    test('getCategoryList parses categories correctly', () async {
      final mockResponse = {
        'categories': [
          {
            'id': '1',
            'name': 'Vegetables',
            'image_path': 'assets/vegetables.png',
            'color': '0xFFE6F2EA',
          },
        ],
      };

      when(
        () => mockApiConsumer.graphql(query: any(named: 'query')),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getCategoryList();

      expect(result.length, 1);
      expect(result.first.name, 'Vegetables');
    });

    test('getCartItems parses cart items correctly', () async {
      final mockResponse = {
        'cart': [
          {
            'id': '1',
            'quantity': 3,
            'product': {
              'id': '1',
              'name': 'Broccoli',
              'image_path': 'assets/broccoli.png',
              'amount': '1 kg',
              'description': 'Fresh',
              'discount': 0.0,
              'price': 4.99,
              'is_new': true,
              'is_favorite': false,
              'color': '0xFFE6F2EA',
              'rating': 4.8,
              'free_shipping': true,
              'same_day_delivery': false,
              'category': {
                'id': '1',
                'name': 'Vegetables',
                'image_path': 'assets/vegetables.png',
                'color': '0xFFE6F2EA',
              },
            },
          },
        ],
      };

      when(
        () => mockApiConsumer.graphql(query: any(named: 'query')),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getCartItems(isFavorites: false);

      expect(result.length, 1);
      expect(result.first.quantity, 3);
      expect(result.first.product.name, 'Broccoli');
    });
  });
}
