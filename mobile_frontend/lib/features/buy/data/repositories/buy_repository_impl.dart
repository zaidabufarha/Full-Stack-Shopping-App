import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/core/network/network_info.dart';
import 'package:big_cart/features/account/data/models/order_model.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/data/data_sources/buy_remote_data_source.dart';
import 'package:big_cart/features/buy/data/models/cart_item_model.dart';
import 'package:big_cart/features/buy/data/models/review_model.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;

@LazySingleton(as: BuyRepository)
class BuyRepositoryImpl implements BuyRepository {
  final BuyRemoteDataSource buyRemoteDataSource;
  final NetworkInfo networkInfo;
  BuyRepositoryImpl(this.buyRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> addReview(String id, Review review) async {
    try {
      await buyRemoteDataSource.addReview(id, ReviewModel.fromEntity(review));
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addToCart(CartItem item) async {
    try {
      await buyRemoteDataSource.addToCart(CartItemModel.fromEntity(item));
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> checkOut(Order order) async {
    try {
      await buyRemoteDataSource.checkOut(OrderModel.fromEntity(order));
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems({
    bool isFavorites = false,
  }) async {
    try {
      final response = await buyRemoteDataSource.getCartItems(
        isFavorites: isFavorites,
      );
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList() async {
    try {
      final response = await buyRemoteDataSource.getCategoryList();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductList() async {
    try {
      final response = await buyRemoteDataSource.getProductList();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getProductReviews(String id) async {
    try {
      final response = await buyRemoteDataSource.getProductReviews(id);
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart(CartItem item) async {
    try {
      await buyRemoteDataSource.removeFromCart(
        CartItemModel.fromEntity(item),
      );
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite(
    String id,
    bool isFavorite,
  ) async {
    try {
      await buyRemoteDataSource.toggleFavorite(id, isFavorite);
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuantity(
    CartItem item,
    int newQuantity,
  ) async {
    try {
      await buyRemoteDataSource.updateQuantity(
        CartItemModel.fromEntity(item),
        newQuantity,
      );
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }
}
