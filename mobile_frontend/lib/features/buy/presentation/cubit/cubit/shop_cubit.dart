import 'package:big_cart/features/auth/domain/use%20cases/get_cached_user.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/domain/use%20cases/add_review.dart';
import 'package:big_cart/features/buy/domain/use%20cases/get_category_list.dart';
import 'package:big_cart/features/buy/domain/use%20cases/get_product_list.dart';
import 'package:big_cart/features/buy/domain/use%20cases/get_product_reviews.dart';
import 'package:big_cart/features/buy/domain/use%20cases/toggle_favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'shop_state.dart';
part 'shop_cubit.freezed.dart';

@injectable
class ShopCubit extends Cubit<ShopState> {
  ShopCubit(
    this.addReview,
    this.getCategoryList,
    this.getProductList,
    this.getProductReviews,
    this.toggleFavorite,
    this.getCachedUser,
  ) : super(ShopState.initial());
  GetCategoryList getCategoryList;
  GetProductList getProductList;
  GetProductReviews getProductReviews;
  AddReview addReview;
  ToggleFavorite toggleFavorite;
  GetCachedUser getCachedUser;

  void attemptAddReview(String id, String content, double rating) async {
    emit(ShopState.loading());
    print('review with rating $rating and content: $content');
    try {
      final review = Review(
        user: (await getCachedUser.call())!,
        comment: content,
        rating: rating,
        createdAt: DateTime.now(),
      );
      final result = await addReview.call(id, review);
      result.fold(
        (failure) {
          emit(ShopState.error(failure.message));
        },
        (unit) {
          emit(ShopState.success('Added review successfully'));
        },
      );
    } catch (e) {
      emit(ShopState.error(e.toString()));
    }
  }

  void attemptGetCategoryList() async {
    emit(ShopState.loading());
    final result = await getCategoryList.call();
    result.fold(
      (failure) {
        emit(ShopState.error(failure.message));
      },
      (list) {
        emit(ShopState.loadedCategories(list));
      },
    );
  }

  void attemptGetProductList() async {
    emit(ShopState.loading());

    final result = await getProductList.call();
    result.fold(
      (failure) {
        emit(ShopState.error(failure.message));
      },
      (list) {
        emit(ShopState.loadedProducts(list));
      },
    );
  }

  void attemptGetProductReviews(String id) async {
    emit(ShopState.loading());
    final result = await getProductReviews.call(id);
    result.fold(
      (failure) {
        emit(ShopState.error(failure.message));
      },
      (list) {
        emit(ShopState.loadedReviews(list));
      },
    );
  }

  void attemptToggleFavorite(String id, bool isFavorite) async {
    final result = await toggleFavorite.call(id, isFavorite);
    result.fold(
      (failure) {
        emit(ShopState.error(failure.message));
      },
      (unit) {
        emit(
          ShopState.success(
            (isFavorite) ? 'Added to favorites' : 'Removed from favorites',
          ),
        );
      },
    );
  }
}
