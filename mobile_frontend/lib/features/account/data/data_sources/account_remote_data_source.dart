import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/models/address_model.dart';
import 'package:big_cart/features/account/data/models/credit_card_model.dart';
import 'package:big_cart/features/account/data/models/notification_preferences_model.dart';
import 'package:big_cart/features/account/data/models/order_model.dart';
import 'package:big_cart/features/account/data/models/transaction_model.dart';
import 'package:big_cart/features/account/data/models/user_model.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AccountRemoteDataSource {
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  });

  Future<void> addCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required bool saveCard,
    required PaymentProcessor processor,
  });
  Future<void> updateCreditCard(CreditCardModel card);
  Future<void> setDefaultCreditCard(String cardId);

  Future<List<CreditCardModel>> getCreditCards();

  Future<void> addProfilePicture({required String path});
  Future<UserModel> getUserData();

  Future<void> addAddress({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  });
  Future<void> updateAddress(AddressModel address);

  Future<List<AddressModel>> getAddresses();

  Future<void> setNotificationPreferences({
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  });

  Future<NotificationPreferencesModel> getNotificationPreferences();
  Future<List<OrderModel>> getOrders();
  Future<List<TransactionModel>> getTransactions();
}

@LazySingleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiConsumer apiConsumer;
  final UserLocalDataSource userLocalDataSource;

  AccountRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.userLocalDataSource,
  });

  @override
  Future<void> addAddress({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  }) async {
    const mutation = r'''
      mutation AddAddress($input: AddressInput!) {
        addAddress(input: $input) {
          id
        }
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {
          'input': {
            'name': name,
            'street': address,
            'city': city,
            'zip_code': zip,
            'country': country,
            'phone': phoneNumber,
            'is_default': makeDefault,
          },
        },
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> addCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required bool saveCard,
    required PaymentProcessor processor,
  }) async {
    const mutation = r'''
      mutation AddCard($input: CardInput!) {
        addCard(input: $input) {
          id
        }
      }
    ''';
    try {
      final cleanNumber = cardNumber.replaceAll(' ', '');
      final last4 = cleanNumber.length >= 4
          ? cleanNumber.substring(cleanNumber.length - 4)
          : cleanNumber;
      await apiConsumer.graphql(
        query: mutation,
        variables: {
          'input': {
            'card_holder_name': name,
            'card_number': cleanNumber,
            'last4': last4,
            'expiry_date': expiration,
            'processor': processor.name,
            'is_default': saveCard,
          },
        },
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> addProfilePicture({required String path}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(path),
        'upload_preset': 'big_cart',
      });

      final cloudinaryDio = Dio();
      final uploadRes = await cloudinaryDio.post(
        'https://api.cloudinary.com/v1_1/jz8fffg2/image/upload',
        data: formData,
      );

      final secureUrl = uploadRes.data['secure_url']?.toString();
      if (secureUrl == null || secureUrl.isEmpty) {
        throw Exception('Cloudinary upload failed');
      }

      const mutation = r'''
        mutation UpdateProfilePicture($imagePath: String!) {
          updateProfile(input: { image_path: $imagePath }) {
            id
            image_path
          }
        }
      ''';
      await apiConsumer.graphql(
        query: mutation,
        variables: {'imagePath': secureUrl},
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    const query = r'''
      query GetAddresses {
        me {
          default_address_id
          address {
            id
            name
            street
            city
            zip_code
            country
            phone
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final defaultId = data['me']['default_address_id']?.toString();
      final list = (data['me']['address'] as List? ?? []);
      return list.map((item) {
        final map = Map<String, dynamic>.from(item);
        final addr = AddressModel.fromJson(map);
        if (defaultId != null && addr.id == defaultId) {
          addr.isDefault = true;
        }
        return addr;
      }).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CreditCardModel>> getCreditCards() async {
    const query = r'''
      query GetCreditCards {
        me {
          default_credit_card_id
          credit_card {
            id
            card_holder_name
            last4
            expiry_date
            stripe_payment_id
            processor
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final defaultId = data['me']['default_credit_card_id']?.toString();
      final list = (data['me']['credit_card'] as List? ?? []);
      return list.map((item) {
        final map = Map<String, dynamic>.from(item);
        final card = CreditCardModel.fromJson(map);
        if (defaultId != null && card.id == defaultId) {
          card.isDefault = true;
        }
        return card;
      }).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<NotificationPreferencesModel> getNotificationPreferences() async {
    const query = r'''
      query GetNotificationPreferences {
        me {
          notification_preference {
            allow_general
            allow_order
            allow_email
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final pref = data['me']['notification_preference'] ?? {};
      return NotificationPreferencesModel.fromJson(
        Map<String, dynamic>.from(pref),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    // BACKEND INTEGRATION: GraphQL me.order query
    const query = r'''
      query GetOrders {
        me {
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
              zip_code
              country
              phone
            }
            credit_card {
              id
              card_holder_name
              last4
              expiry_date
              stripe_payment_id
              processor
            }
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final list = (data['me']['order'] as List? ?? []);
      return list
          .map((item) => OrderModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    // BACKEND INTEGRATION: GraphQL me.transaction query
    const query = r'''
      query GetTransactions {
        me {
          transaction {
            id
            amount
            status
            payment_method
            created_at
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final list = (data['me']['transaction'] as List? ?? []);
      return list
          .map(
            (item) =>
                TransactionModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<UserModel> getUserData() async {
    // BACKEND INTEGRATION: GraphQL me query
    const query = r'''
      query GetUserData {
        me {
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
            zip_code
            country
            phone
          }
          credit_card {
            id
            card_holder_name
            last4
            expiry_date
            stripe_payment_id
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
              zip_code
              country
              phone
            }
            credit_card {
              id
              card_holder_name
              last4
              expiry_date
              stripe_payment_id
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
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final user = UserModel.fromJson(Map<String, dynamic>.from(data['me']));
      return user;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> setNotificationPreferences({
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  }) async {
    // BACKEND INTEGRATION: GraphQL updateNotificationPreference mutation
    const mutation = r'''
      mutation UpdateNotificationPreference($email: Boolean, $order: Boolean, $general: Boolean) {
        updateNotificationPreference(allow_email: $email, allow_order: $order, allow_general: $general) {
          id
        }
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {
          'email': allowEmailNotifications,
          'order': allowOrderNotifications,
          'general': allowGeneralNotifications,
        },
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    const mutation = r'''
      mutation UpdateAddress($id: ID!, $input: AddressInput!) {
        updateAddress(id: $id, input: $input) {
          id
        }
      }
    ''';
    try {
      if (address.id != null) {
        await apiConsumer.graphql(
          query: mutation,
          variables: {
            'id': address.id,
            'input': {
              'name': address.name,
              'street': address.street,
              'city': address.city,
              'zip_code': address.zipCode,
              'country': address.country,
              'phone': address.phone,
              'is_default': address.isDefault,
            },
          },
        );
      }
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateCreditCard(CreditCardModel card) async {
    const mutation = r'''
      mutation UpdateCreditCard($id: ID!, $input: CardInput!) {
        updateCreditCard(id: $id, input: $input) {
          id
        }
      }
    ''';
    try {
      if (card.id != null) {
        await apiConsumer.graphql(
          query: mutation,
          variables: {
            'id': card.id,
            'input': {
              'card_holder_name': card.cardHolderName,
              'last4': card.last4,
              'expiry_date': card.expiryDate,
              'processor': card.processor.name,
              'is_default': card.isDefault,
            },
          },
        );
      }
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> setDefaultCreditCard(String cardId) async {
    const mutation = r'''
      mutation SetDefaultCreditCard($id: ID!) {
        setDefaultCreditCard(id: $id) {
          id
        }
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {'id': cardId},
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    // BACKEND INTEGRATION: GraphQL updateProfile and changePassword mutations
    try {
      if (newPassword1.isNotEmpty) {
        if (newPassword1 != newPassword2) {
          throw PasswordMismatchException();
        }
        await apiConsumer.graphql(
          query: r'''
            mutation ChangePassword($oldPassword: String!, $newPassword: String!) {
              changePassword(oldPassword: $oldPassword, newPassword: $newPassword)
            }
          ''',
          variables: {
            'oldPassword': currentPassword,
            'newPassword': newPassword1,
          },
        );
      }

      await apiConsumer.graphql(
        query: r'''
          mutation UpdateProfile($name: String, $email: String, $phone: String) {
            updateProfile(input: { name: $name, email: $email, phone: $phone }) {
              id
              name
              email
              phone
            }
          }
        ''',
        variables: {
          'name': name,
          'email': email,
          'phone': phoneNumber,
        },
      );
    } on DioException {
      throw NoInternetException();
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('incorrect') || msg.contains('wrong password')) {
        throw WrongPasswordException();
      }
      rethrow;
    }
  }
}
