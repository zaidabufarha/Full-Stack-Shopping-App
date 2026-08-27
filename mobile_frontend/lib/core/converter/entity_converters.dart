import 'package:big_cart/features/account/data/models/address_model.dart';
import 'package:big_cart/features/account/data/models/credit_card_model.dart';
import 'package:big_cart/features/account/data/models/order_model.dart';
import 'package:big_cart/features/account/data/models/transaction_model.dart';
import 'package:big_cart/features/account/data/models/user_model.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/buy/data/models/cart_item_model.dart';
import 'package:big_cart/features/buy/data/models/category_model.dart';
import 'package:big_cart/features/buy/data/models/product_model.dart';
import 'package:big_cart/features/buy/data/models/review_model.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class AddressConverter implements JsonConverter<Address, dynamic> {
  const AddressConverter();
  @override
  Address fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return AddressModel.fromJson(json);
    if (json is Map) return AddressModel.fromJson(Map<String, dynamic>.from(json));
    return AddressModel(name: '', street: '', city: '', country: '', phone: '', zipCode: '');
  }
  @override
  dynamic toJson(Address object) => (object as AddressModel).toJson();
}

class CreditCardConverter implements JsonConverter<CreditCard, dynamic> {
  const CreditCardConverter();
  @override
  CreditCard fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return CreditCardModel.fromJson(json);
    if (json is Map) return CreditCardModel.fromJson(Map<String, dynamic>.from(json));
    return CreditCardModel(cardHolderName: '', cardNumber: '', expiryDate: '', cvv: '', processor: PaymentProcessor.mastercard);
  }
  @override
  dynamic toJson(CreditCard object) => (object as CreditCardModel).toJson();
}

class OrderConverter implements JsonConverter<Order, dynamic> {
  const OrderConverter();
  @override
  Order fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return OrderModel.fromJson(json);
    if (json is Map) return OrderModel.fromJson(Map<String, dynamic>.from(json));
    return OrderModel(
      orderItem: [],
      createdAt: DateTime.now(),
      address: AddressModel(name: '', street: '', city: '', country: '', phone: '', zipCode: ''),
      creditCard: CreditCardModel(cardHolderName: '', cardNumber: '', expiryDate: '', cvv: '', processor: PaymentProcessor.mastercard),
      shippingMethod: '',
    );
  }
  @override
  dynamic toJson(Order object) => (object as OrderModel).toJson();
}

class TransactionConverter implements JsonConverter<Transaction, dynamic> {
  const TransactionConverter();
  @override
  Transaction fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return TransactionModel.fromJson(json);
    if (json is Map) return TransactionModel.fromJson(Map<String, dynamic>.from(json));
    return TransactionModel(amount: 0.0, createdAt: DateTime.now(), paymentMethod: PaymentProcessor.mastercard);
  }
  @override
  dynamic toJson(Transaction object) => (object as TransactionModel).toJson();
}

class CategoryConverter implements JsonConverter<Category, dynamic> {
  const CategoryConverter();
  @override
  Category fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return CategoryModel.fromJson(json);
    if (json is Map) return CategoryModel.fromJson(Map<String, dynamic>.from(json));
    return CategoryModel(
      name: 'General',
      imagePath: 'https://res.cloudinary.com/jz8fffg2/image/upload/vegetable.png',
      color: const Color(0xFF4CAF50),
    );
  }
  @override
  dynamic toJson(Category object) => (object as CategoryModel).toJson();
}

class ProductConverter implements JsonConverter<Product, dynamic> {
  const ProductConverter();
  @override
  Product fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return ProductModel.fromJson(json);
    if (json is Map) return ProductModel.fromJson(Map<String, dynamic>.from(json));
    return ProductModel(
      id: '0',
      name: '',
      imagePath: '',
      amount: '',
      description: '',
      discount: 0,
      price: 0,
      isNew: false,
      category: CategoryModel(name: '', imagePath: '', color: Colors.green),
      color: Colors.green,
    );
  }
  @override
  dynamic toJson(Product object) => (object as ProductModel).toJson();
}

class ReviewConverter implements JsonConverter<Review, dynamic> {
  const ReviewConverter();
  @override
  Review fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return ReviewModel.fromJson(json);
    if (json is Map) return ReviewModel.fromJson(Map<String, dynamic>.from(json));
    return ReviewModel(
      user: UserModel(name: '', email: '', phone: ''),
      comment: '',
      rating: 5.0,
      createdAt: DateTime.now(),
    );
  }
  @override
  dynamic toJson(Review object) => (object as ReviewModel).toJson();
}

class UserConverter implements JsonConverter<User, dynamic> {
  const UserConverter();
  @override
  User fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return UserModel.fromJson(json);
    if (json is Map) return UserModel.fromJson(Map<String, dynamic>.from(json));
    return UserModel(name: '', email: '', phone: '');
  }
  @override
  dynamic toJson(User object) => (object as UserModel).toJson();
}

class CartItemConverter implements JsonConverter<CartItem, dynamic> {
  const CartItemConverter();
  @override
  CartItem fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return CartItemModel.fromJson(json);
    if (json is Map) return CartItemModel.fromJson(Map<String, dynamic>.from(json));
    return CartItemModel(
      ProductModel(
        id: '0',
        name: '',
        imagePath: '',
        amount: '',
        description: '',
        discount: 0,
        price: 0,
        isNew: false,
        category: CategoryModel(name: '', imagePath: '', color: Colors.green),
        color: Colors.green,
      ),
      1,
    );
  }
  @override
  dynamic toJson(CartItem object) => (object as CartItemModel).toJson();
}

class PaymentProcessorConverter implements JsonConverter<PaymentProcessor, dynamic> {
  const PaymentProcessorConverter();
  @override
  PaymentProcessor fromJson(dynamic json) {
    final lower = json?.toString().toLowerCase() ?? '';
    if (lower.contains('visa')) return PaymentProcessor.visa;
    if (lower.contains('paypal')) return PaymentProcessor.paypal;
    return PaymentProcessor.mastercard;
  }
  @override
  dynamic toJson(PaymentProcessor object) => object.name;
}
