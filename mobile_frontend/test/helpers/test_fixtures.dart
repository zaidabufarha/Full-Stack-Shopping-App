import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class DummyFailure extends Failure {
  DummyFailure([super.message = 'Test error message']);
}

final testAddress = Address(
  id: 'addr_1',
  name: 'Home',
  street: '123 Main St',
  city: 'Springfield',
  country: 'USA',
  phone: '+1234567890',
  zipCode: '12345',
  isDefault: true,
);

final testCreditCard = CreditCard(
  id: 'card_1',
  cardHolderName: 'John Doe',
  last4: '4242',
  expiryDate: '12/28',
  stripePaymentId: 'pm_12345',
  processor: PaymentProcessor.visa,
  isDefault: true,
);

final testCategory = Category(
  name: 'Fruits',
  imagePath: 'assets/fruit.png',
  color: const Color(0xFFE6F2EA),
);

final testUser = User(
  name: 'John Doe',
  email: 'john@example.com',
  phone: '+1234567890',
  password: 'password123',
  imagePath: 'assets/blank_profile_picture.png',
  defaultAddress: testAddress,
  creditCard: [testCreditCard],
  address: [testAddress],
  order: const [],
  transaction: const [],
);

final testReview = Review(
  user: testUser,
  comment: 'Great product!',
  rating: 5.0,
  createdAt: DateTime(2026, 1, 1),
);

final testProduct = Product(
  id: 'prod_1',
  name: 'Fresh Apple',
  imagePath: 'assets/apple.png',
  amount: '1 kg',
  description: 'Fresh organic apples',
  discount: 0.1,
  price: 5.0,
  isNew: true,
  isFavorite: false,
  category: testCategory,
  color: const Color(0xFFFFEAEA),
  review: [testReview],
);

final testCartItem = CartItem(testProduct, 2);

final testOrder = Order(
  id: 'order_1',
  orderItem: [testCartItem],
  address: testAddress,
  creditCard: testCreditCard,
  shippingMethod: 'Standard',
  createdAt: DateTime(2026, 1, 1),
);

final testTransaction = Transaction(
  amount: 50.0,
  createdAt: DateTime(2026, 1, 1),
  paymentMethod: PaymentProcessor.visa,
);

final testNotificationPreferences = NotificationPreferences(
  allowEmail: true,
  allowGeneral: true,
  allowOrder: true,
);

void registerAllFallbackValues() {
  registerFallbackValue(testUser);
  registerFallbackValue(testAddress);
  registerFallbackValue(testCreditCard);
  registerFallbackValue(testCategory);
  registerFallbackValue(testReview);
  registerFallbackValue(testProduct);
  registerFallbackValue(testCartItem);
  registerFallbackValue(testOrder);
  registerFallbackValue(testTransaction);
  registerFallbackValue(testNotificationPreferences);
  registerFallbackValue(PaymentProcessor.visa);
}
