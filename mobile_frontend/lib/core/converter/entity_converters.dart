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
import 'package:freezed_annotation/freezed_annotation.dart';

class CartItemConverter
    implements JsonConverter<CartItem, Map<String, dynamic>> {
  const CartItemConverter();
  @override
  CartItem fromJson(Map<String, dynamic> json) => CartItemModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(CartItem object) =>
      (object as CartItemModel).toJson();
}

class AddressConverter
    implements JsonConverter<Address, Map<String, dynamic>> {
  const AddressConverter();
  @override
  Address fromJson(Map<String, dynamic> json) => AddressModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(Address object) =>
      AddressModel.fromEntity(object).toJson();
}

class CreditCardConverter
    implements JsonConverter<CreditCard, Map<String, dynamic>> {
  const CreditCardConverter();
  @override
  CreditCard fromJson(Map<String, dynamic> json) =>
      CreditCardModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(CreditCard object) =>
      CreditCardModel.fromEntity(object).toJson();
}

class OrderConverter implements JsonConverter<Order, Map<String, dynamic>> {
  const OrderConverter();
  @override
  Order fromJson(Map<String, dynamic> json) => OrderModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(Order object) => (object as OrderModel).toJson();
}

class TransactionConverter
    implements JsonConverter<Transaction, Map<String, dynamic>> {
  const TransactionConverter();
  @override
  Transaction fromJson(Map<String, dynamic> json) =>
      TransactionModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(Transaction object) =>
      (object as TransactionModel).toJson();
}

class CategoryConverter
    implements JsonConverter<Category, Map<String, dynamic>> {
  const CategoryConverter();
  @override
  Category fromJson(Map<String, dynamic> json) => CategoryModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(Category object) =>
      (object as CategoryModel).toJson();
}

class ProductConverter
    implements JsonConverter<Product, Map<String, dynamic>> {
  const ProductConverter();
  @override
  Product fromJson(Map<String, dynamic> json) => ProductModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(Product object) =>
      (object as ProductModel).toJson();
}

class ReviewConverter implements JsonConverter<Review, Map<String, dynamic>> {
  const ReviewConverter();
  @override
  Review fromJson(Map<String, dynamic> json) => ReviewModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(Review object) =>
      (object as ReviewModel).toJson();
}

class UserConverter implements JsonConverter<User, Map<String, dynamic>> {
  const UserConverter();
  @override
  User fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);
  @override
  Map<String, dynamic> toJson(User object) =>
      UserModel.fromEntity(object).toJson();
}
