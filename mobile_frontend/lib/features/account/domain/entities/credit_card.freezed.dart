// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditCard {

 String? get id; String get cardHolderName; String get last4; String get expiryDate; String? get stripePaymentId; PaymentProcessor get processor; bool get isDefault;
/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCardCopyWith<CreditCard> get copyWith => _$CreditCardCopyWithImpl<CreditCard>(this as CreditCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCard&&(identical(other.id, id) || other.id == id)&&(identical(other.cardHolderName, cardHolderName) || other.cardHolderName == cardHolderName)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.stripePaymentId, stripePaymentId) || other.stripePaymentId == stripePaymentId)&&(identical(other.processor, processor) || other.processor == processor)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}


@override
int get hashCode => Object.hash(runtimeType,id,cardHolderName,last4,expiryDate,stripePaymentId,processor,isDefault);

@override
String toString() {
  return 'CreditCard(id: $id, cardHolderName: $cardHolderName, last4: $last4, expiryDate: $expiryDate, stripePaymentId: $stripePaymentId, processor: $processor, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $CreditCardCopyWith<$Res>  {
  factory $CreditCardCopyWith(CreditCard value, $Res Function(CreditCard) _then) = _$CreditCardCopyWithImpl;
@useResult
$Res call({
 String? id, String cardHolderName, String last4, String expiryDate, String? stripePaymentId, PaymentProcessor processor, bool isDefault
});




}
/// @nodoc
class _$CreditCardCopyWithImpl<$Res>
    implements $CreditCardCopyWith<$Res> {
  _$CreditCardCopyWithImpl(this._self, this._then);

  final CreditCard _self;
  final $Res Function(CreditCard) _then;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? cardHolderName = null,Object? last4 = null,Object? expiryDate = null,Object? stripePaymentId = freezed,Object? processor = null,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,cardHolderName: null == cardHolderName ? _self.cardHolderName : cardHolderName // ignore: cast_nullable_to_non_nullable
as String,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,stripePaymentId: freezed == stripePaymentId ? _self.stripePaymentId : stripePaymentId // ignore: cast_nullable_to_non_nullable
as String?,processor: null == processor ? _self.processor : processor // ignore: cast_nullable_to_non_nullable
as PaymentProcessor,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditCard].
extension CreditCardPatterns on CreditCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditCard value)  $default,){
final _that = this;
switch (_that) {
case _CreditCard():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditCard value)?  $default,){
final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String cardHolderName,  String last4,  String expiryDate,  String? stripePaymentId,  PaymentProcessor processor,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that.id,_that.cardHolderName,_that.last4,_that.expiryDate,_that.stripePaymentId,_that.processor,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String cardHolderName,  String last4,  String expiryDate,  String? stripePaymentId,  PaymentProcessor processor,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _CreditCard():
return $default(_that.id,_that.cardHolderName,_that.last4,_that.expiryDate,_that.stripePaymentId,_that.processor,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String cardHolderName,  String last4,  String expiryDate,  String? stripePaymentId,  PaymentProcessor processor,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _CreditCard() when $default != null:
return $default(_that.id,_that.cardHolderName,_that.last4,_that.expiryDate,_that.stripePaymentId,_that.processor,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc


class _CreditCard implements CreditCard {
  const _CreditCard({this.id, required this.cardHolderName, required this.last4, required this.expiryDate, this.stripePaymentId = 'pm_mock_12345', required this.processor, this.isDefault = false});
  

@override final  String? id;
@override final  String cardHolderName;
@override final  String last4;
@override final  String expiryDate;
@override@JsonKey() final  String? stripePaymentId;
@override final  PaymentProcessor processor;
@override@JsonKey() final  bool isDefault;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditCardCopyWith<_CreditCard> get copyWith => __$CreditCardCopyWithImpl<_CreditCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditCard&&(identical(other.id, id) || other.id == id)&&(identical(other.cardHolderName, cardHolderName) || other.cardHolderName == cardHolderName)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.stripePaymentId, stripePaymentId) || other.stripePaymentId == stripePaymentId)&&(identical(other.processor, processor) || other.processor == processor)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}


@override
int get hashCode => Object.hash(runtimeType,id,cardHolderName,last4,expiryDate,stripePaymentId,processor,isDefault);

@override
String toString() {
  return 'CreditCard(id: $id, cardHolderName: $cardHolderName, last4: $last4, expiryDate: $expiryDate, stripePaymentId: $stripePaymentId, processor: $processor, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$CreditCardCopyWith<$Res> implements $CreditCardCopyWith<$Res> {
  factory _$CreditCardCopyWith(_CreditCard value, $Res Function(_CreditCard) _then) = __$CreditCardCopyWithImpl;
@override @useResult
$Res call({
 String? id, String cardHolderName, String last4, String expiryDate, String? stripePaymentId, PaymentProcessor processor, bool isDefault
});




}
/// @nodoc
class __$CreditCardCopyWithImpl<$Res>
    implements _$CreditCardCopyWith<$Res> {
  __$CreditCardCopyWithImpl(this._self, this._then);

  final _CreditCard _self;
  final $Res Function(_CreditCard) _then;

/// Create a copy of CreditCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? cardHolderName = null,Object? last4 = null,Object? expiryDate = null,Object? stripePaymentId = freezed,Object? processor = null,Object? isDefault = null,}) {
  return _then(_CreditCard(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,cardHolderName: null == cardHolderName ? _self.cardHolderName : cardHolderName // ignore: cast_nullable_to_non_nullable
as String,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,stripePaymentId: freezed == stripePaymentId ? _self.stripePaymentId : stripePaymentId // ignore: cast_nullable_to_non_nullable
as String?,processor: null == processor ? _self.processor : processor // ignore: cast_nullable_to_non_nullable
as PaymentProcessor,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
