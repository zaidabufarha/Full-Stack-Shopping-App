// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopState()';
}


}

/// @nodoc
class $ShopStateCopyWith<$Res>  {
$ShopStateCopyWith(ShopState _, $Res Function(ShopState) __);
}


/// Adds pattern-matching-related methods to [ShopState].
extension ShopStatePatterns on ShopState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _LoadedProducts value)?  loadedProducts,TResult Function( _LoadedCategories value)?  loadedCategories,TResult Function( _LoadedReviews value)?  loadedReviews,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _LoadedProducts() when loadedProducts != null:
return loadedProducts(_that);case _LoadedCategories() when loadedCategories != null:
return loadedCategories(_that);case _LoadedReviews() when loadedReviews != null:
return loadedReviews(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _LoadedProducts value)  loadedProducts,required TResult Function( _LoadedCategories value)  loadedCategories,required TResult Function( _LoadedReviews value)  loadedReviews,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _LoadedProducts():
return loadedProducts(_that);case _LoadedCategories():
return loadedCategories(_that);case _LoadedReviews():
return loadedReviews(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _LoadedProducts value)?  loadedProducts,TResult? Function( _LoadedCategories value)?  loadedCategories,TResult? Function( _LoadedReviews value)?  loadedReviews,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _LoadedProducts() when loadedProducts != null:
return loadedProducts(_that);case _LoadedCategories() when loadedCategories != null:
return loadedCategories(_that);case _LoadedReviews() when loadedReviews != null:
return loadedReviews(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Product> products)?  loadedProducts,TResult Function( List<Category> categories)?  loadedCategories,TResult Function( List<Review> reviews)?  loadedReviews,TResult Function( String message)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _LoadedProducts() when loadedProducts != null:
return loadedProducts(_that.products);case _LoadedCategories() when loadedCategories != null:
return loadedCategories(_that.categories);case _LoadedReviews() when loadedReviews != null:
return loadedReviews(_that.reviews);case _Success() when success != null:
return success(_that.message);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Product> products)  loadedProducts,required TResult Function( List<Category> categories)  loadedCategories,required TResult Function( List<Review> reviews)  loadedReviews,required TResult Function( String message)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _LoadedProducts():
return loadedProducts(_that.products);case _LoadedCategories():
return loadedCategories(_that.categories);case _LoadedReviews():
return loadedReviews(_that.reviews);case _Success():
return success(_that.message);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Product> products)?  loadedProducts,TResult? Function( List<Category> categories)?  loadedCategories,TResult? Function( List<Review> reviews)?  loadedReviews,TResult? Function( String message)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _LoadedProducts() when loadedProducts != null:
return loadedProducts(_that.products);case _LoadedCategories() when loadedCategories != null:
return loadedCategories(_that.categories);case _LoadedReviews() when loadedReviews != null:
return loadedReviews(_that.reviews);case _Success() when success != null:
return success(_that.message);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ShopState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopState.initial()';
}


}




/// @nodoc


class _Loading implements ShopState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopState.loading()';
}


}




/// @nodoc


class _LoadedProducts implements ShopState {
  const _LoadedProducts(final  List<Product> products): _products = products;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedProductsCopyWith<_LoadedProducts> get copyWith => __$LoadedProductsCopyWithImpl<_LoadedProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedProducts&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'ShopState.loadedProducts(products: $products)';
}


}

/// @nodoc
abstract mixin class _$LoadedProductsCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$LoadedProductsCopyWith(_LoadedProducts value, $Res Function(_LoadedProducts) _then) = __$LoadedProductsCopyWithImpl;
@useResult
$Res call({
 List<Product> products
});




}
/// @nodoc
class __$LoadedProductsCopyWithImpl<$Res>
    implements _$LoadedProductsCopyWith<$Res> {
  __$LoadedProductsCopyWithImpl(this._self, this._then);

  final _LoadedProducts _self;
  final $Res Function(_LoadedProducts) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,}) {
  return _then(_LoadedProducts(
null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class _LoadedCategories implements ShopState {
  const _LoadedCategories(final  List<Category> categories): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCategoriesCopyWith<_LoadedCategories> get copyWith => __$LoadedCategoriesCopyWithImpl<_LoadedCategories>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedCategories&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'ShopState.loadedCategories(categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$LoadedCategoriesCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$LoadedCategoriesCopyWith(_LoadedCategories value, $Res Function(_LoadedCategories) _then) = __$LoadedCategoriesCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class __$LoadedCategoriesCopyWithImpl<$Res>
    implements _$LoadedCategoriesCopyWith<$Res> {
  __$LoadedCategoriesCopyWithImpl(this._self, this._then);

  final _LoadedCategories _self;
  final $Res Function(_LoadedCategories) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(_LoadedCategories(
null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

/// @nodoc


class _LoadedReviews implements ShopState {
  const _LoadedReviews(final  List<Review> reviews): _reviews = reviews;
  

 final  List<Review> _reviews;
 List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedReviewsCopyWith<_LoadedReviews> get copyWith => __$LoadedReviewsCopyWithImpl<_LoadedReviews>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedReviews&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'ShopState.loadedReviews(reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$LoadedReviewsCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$LoadedReviewsCopyWith(_LoadedReviews value, $Res Function(_LoadedReviews) _then) = __$LoadedReviewsCopyWithImpl;
@useResult
$Res call({
 List<Review> reviews
});




}
/// @nodoc
class __$LoadedReviewsCopyWithImpl<$Res>
    implements _$LoadedReviewsCopyWith<$Res> {
  __$LoadedReviewsCopyWithImpl(this._self, this._then);

  final _LoadedReviews _self;
  final $Res Function(_LoadedReviews) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reviews = null,}) {
  return _then(_LoadedReviews(
null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,
  ));
}


}

/// @nodoc


class _Success implements ShopState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ShopState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements ShopState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ShopState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
