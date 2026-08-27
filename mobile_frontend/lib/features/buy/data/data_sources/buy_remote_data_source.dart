import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/models/order_model.dart';
import 'package:big_cart/features/buy/data/models/cart_item_model.dart';
import 'package:big_cart/features/buy/data/models/category_model.dart';
import 'package:big_cart/features/buy/data/models/product_model.dart';
import 'package:big_cart/features/buy/data/models/review_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class BuyRemoteDataSource {
  Future<List<CategoryModel>> getCategoryList();
  Future<List<ProductModel>> getProductList();
  Future<List<ReviewModel>> getProductReviews(String id);
  Future<List<CartItemModel>> getCartItems({bool isFavorites = false});
  Future<Unit> addToCart(CartItemModel item);
  Future<Unit> addReview(String id, ReviewModel review);
  Future<Unit> checkOut(OrderModel order);
  Future<Unit> toggleFavorite(String id, bool isFavorite);
  Future<Unit> updateQuantity(
    CartItemModel item,
    int newQuantity,
  );
  Future<Unit> removeFromCart(CartItemModel item);
}

@LazySingleton(as: BuyRemoteDataSource)
class BuyRemoteDataSourceImpl implements BuyRemoteDataSource {
  final ApiConsumer apiConsumer;
  final UserLocalDataSource userLocalDataSource;

  BuyRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.userLocalDataSource,
  });

  @override
  Future<Unit> addReview(String id, ReviewModel review) async {
    const mutation = r'''
      mutation AddReview($productId: ID!, $rating: Float!, $comment: String!) {
        addReview(product_id: $productId, rating: $rating, comment: $comment) {
          id
        }
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {
          'productId': id,
          'rating': review.rating,
          'comment': review.comment,
        },
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> addToCart(CartItemModel item) async {
    const mutation = r'''
      mutation AddToCart($productId: ID!, $quantity: Int!) {
        addToCart(product_id: $productId, quantity: $quantity) {
          id
        }
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {
          'productId': item.product.id,
          'quantity': item.quantity,
        },
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> checkOut(OrderModel order) async {
    const mutation = r'''
      mutation CreateOrder($addressId: ID!, $cardId: ID!, $shippingMethod: String) {
        createOrder(address_id: $addressId, card_id: $cardId, shipping_method: $shippingMethod) {
          id
        }
      }
    ''';
    try {
      final addressId = order.address.id ?? '1';
      final cardId = order.creditCard.id ?? '1';
      await apiConsumer.graphql(
        query: mutation,
        variables: {
          'addressId': addressId,
          'cardId': cardId,
          'shippingMethod': order.shippingMethod,
        },
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems({bool isFavorites = false}) async {
    try {
      if (isFavorites) {
        const favQuery = r'''
          query GetFavorites {
            me {
              favorite {
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
                free_shipping
                same_day_delivery
                category {
                  id
                  name
                  image_path
                  color
                }
              }
            }
          }
        ''';
        final data = await apiConsumer.graphql(query: favQuery);
        final favList = (data['me']['favorite'] as List? ?? []);
        return favList.map((item) {
          final prod = ProductModel.fromJson(Map<String, dynamic>.from(item));
          prod.isFavorite = true;
          return CartItemModel(prod, 1);
        }).toList();
      } else {
        const cartQuery = r'''
          query GetCart {
            cart {
              id
              quantity
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
                free_shipping
                same_day_delivery
                category {
                  id
                  name
                  image_path
                  color
                }
              }
            }
          }
        ''';
        final data = await apiConsumer.graphql(query: cartQuery);
        final list = (data['cart'] as List? ?? []);
        return list.map((item) {
          final prod = ProductModel.fromJson(
            Map<String, dynamic>.from(item['product']),
          );
          return CartItemModel(prod, item['quantity'] as int);
        }).toList();
      }
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CategoryModel>> getCategoryList() async {
    const query = r'''
      query GetCategories {
        categories {
          id
          name
          image_path
          color
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final list = (data['categories'] as List? ?? []);
      if (list.isEmpty) {
        throw NoDataException();
      }
      return list
          .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<ProductModel>> getProductList() async {
    const query = r'''
      query GetProducts {
        products {
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
          free_shipping
          same_day_delivery
          category {
            id
            name
            image_path
            color
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(query: query);
      final list = (data['products'] as List? ?? []);
      if (list.isEmpty) {
        throw NoDataException();
      }
      return list
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<ReviewModel>> getProductReviews(String id) async {
    const query = r'''
      query GetProductReviews($productId: ID!) {
        productReviews(product_id: $productId) {
          id
          rating
          comment
          created_at
          user {
            name
            image_path
          }
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(
        query: query,
        variables: {'productId': id},
      );
      final list = (data['productReviews'] as List? ?? []);
      return list
          .map((e) => ReviewModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> removeFromCart(CartItemModel item) async {
    try {
      final cartData = await apiConsumer.graphql(
        query: r'''
        query GetCartIds {
          cart {
            id
            product {
              id
            }
          }
        }
      ''',
      );
      final items = cartData['cart'] as List? ?? [];
      final match = items.firstWhere(
        (e) => e['product']['id'].toString() == item.product.id.toString(),
        orElse: () => null,
      );
      if (match != null) {
        await apiConsumer.graphql(
          query: r'''
            mutation RemoveFromCart($id: ID!) {
              removeFromCart(cart_item_id: $id)
            }
          ''',
          variables: {'id': match['id'].toString()},
        );
      }
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> toggleFavorite(String id, bool isFavorite) async {
    const mutation = r'''
      mutation ToggleFavorite($productId: ID!) {
        toggleFavorite(product_id: $productId)
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {'productId': id},
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> updateQuantity(CartItemModel item, int newQuantity) async {
    try {
      final cartData = await apiConsumer.graphql(
        query: r'''
        query GetCartIds {
          cart {
            id
            product {
              id
            }
          }
        }
      ''',
      );
      final items = cartData['cart'] as List? ?? [];
      final match = items.firstWhere(
        (e) => e['product']['id'].toString() == item.product.id.toString(),
        orElse: () => null,
      );
      if (match != null) {
        await apiConsumer.graphql(
          query: r'''
            mutation UpdateCartItem($id: ID!, $quantity: Int!) {
              updateCartItem(cart_item_id: $id, quantity: $quantity) {
                id
              }
            }
          ''',
          variables: {'id': match['id'].toString(), 'quantity': newQuantity},
        );
      }
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }
}
