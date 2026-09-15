// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Order {

 String? get id; List<CartItem> get orderItem; Address get address; CreditCard get creditCard; String get shippingMethod; DateTime get datePlaced; DateTime? get dateConfirmed; DateTime? get dateDelivered; DateTime? get dateOutForDelivery; DateTime? get dateShipped;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.orderItem, orderItem)&&(identical(other.address, address) || other.address == address)&&(identical(other.creditCard, creditCard) || other.creditCard == creditCard)&&(identical(other.shippingMethod, shippingMethod) || other.shippingMethod == shippingMethod)&&(identical(other.datePlaced, datePlaced) || other.datePlaced == datePlaced)&&(identical(other.dateConfirmed, dateConfirmed) || other.dateConfirmed == dateConfirmed)&&(identical(other.dateDelivered, dateDelivered) || other.dateDelivered == dateDelivered)&&(identical(other.dateOutForDelivery, dateOutForDelivery) || other.dateOutForDelivery == dateOutForDelivery)&&(identical(other.dateShipped, dateShipped) || other.dateShipped == dateShipped));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(orderItem),address,creditCard,shippingMethod,datePlaced,dateConfirmed,dateDelivered,dateOutForDelivery,dateShipped);

@override
String toString() {
  return 'Order(id: $id, orderItem: $orderItem, address: $address, creditCard: $creditCard, shippingMethod: $shippingMethod, datePlaced: $datePlaced, dateConfirmed: $dateConfirmed, dateDelivered: $dateDelivered, dateOutForDelivery: $dateOutForDelivery, dateShipped: $dateShipped)';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String? id, List<CartItem> orderItem, Address address, CreditCard creditCard, String shippingMethod, DateTime datePlaced, DateTime? dateConfirmed, DateTime? dateDelivered, DateTime? dateOutForDelivery, DateTime? dateShipped
});


$AddressCopyWith<$Res> get address;$CreditCardCopyWith<$Res> get creditCard;

}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? orderItem = null,Object? address = null,Object? creditCard = null,Object? shippingMethod = null,Object? datePlaced = null,Object? dateConfirmed = freezed,Object? dateDelivered = freezed,Object? dateOutForDelivery = freezed,Object? dateShipped = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,orderItem: null == orderItem ? _self.orderItem : orderItem // ignore: cast_nullable_to_non_nullable
as List<CartItem>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,creditCard: null == creditCard ? _self.creditCard : creditCard // ignore: cast_nullable_to_non_nullable
as CreditCard,shippingMethod: null == shippingMethod ? _self.shippingMethod : shippingMethod // ignore: cast_nullable_to_non_nullable
as String,datePlaced: null == datePlaced ? _self.datePlaced : datePlaced // ignore: cast_nullable_to_non_nullable
as DateTime,dateConfirmed: freezed == dateConfirmed ? _self.dateConfirmed : dateConfirmed // ignore: cast_nullable_to_non_nullable
as DateTime?,dateDelivered: freezed == dateDelivered ? _self.dateDelivered : dateDelivered // ignore: cast_nullable_to_non_nullable
as DateTime?,dateOutForDelivery: freezed == dateOutForDelivery ? _self.dateOutForDelivery : dateOutForDelivery // ignore: cast_nullable_to_non_nullable
as DateTime?,dateShipped: freezed == dateShipped ? _self.dateShipped : dateShipped // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditCardCopyWith<$Res> get creditCard {
  
  return $CreditCardCopyWith<$Res>(_self.creditCard, (value) {
    return _then(_self.copyWith(creditCard: value));
  });
}
}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  List<CartItem> orderItem,  Address address,  CreditCard creditCard,  String shippingMethod,  DateTime datePlaced,  DateTime? dateConfirmed,  DateTime? dateDelivered,  DateTime? dateOutForDelivery,  DateTime? dateShipped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.orderItem,_that.address,_that.creditCard,_that.shippingMethod,_that.datePlaced,_that.dateConfirmed,_that.dateDelivered,_that.dateOutForDelivery,_that.dateShipped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  List<CartItem> orderItem,  Address address,  CreditCard creditCard,  String shippingMethod,  DateTime datePlaced,  DateTime? dateConfirmed,  DateTime? dateDelivered,  DateTime? dateOutForDelivery,  DateTime? dateShipped)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.orderItem,_that.address,_that.creditCard,_that.shippingMethod,_that.datePlaced,_that.dateConfirmed,_that.dateDelivered,_that.dateOutForDelivery,_that.dateShipped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  List<CartItem> orderItem,  Address address,  CreditCard creditCard,  String shippingMethod,  DateTime datePlaced,  DateTime? dateConfirmed,  DateTime? dateDelivered,  DateTime? dateOutForDelivery,  DateTime? dateShipped)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.orderItem,_that.address,_that.creditCard,_that.shippingMethod,_that.datePlaced,_that.dateConfirmed,_that.dateDelivered,_that.dateOutForDelivery,_that.dateShipped);case _:
  return null;

}
}

}

/// @nodoc


class _Order implements Order {
  const _Order({this.id, required final  List<CartItem> orderItem, required this.address, required this.creditCard, required this.shippingMethod, required this.datePlaced, this.dateConfirmed, this.dateDelivered, this.dateOutForDelivery, this.dateShipped}): _orderItem = orderItem;
  

@override final  String? id;
 final  List<CartItem> _orderItem;
@override List<CartItem> get orderItem {
  if (_orderItem is EqualUnmodifiableListView) return _orderItem;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderItem);
}

@override final  Address address;
@override final  CreditCard creditCard;
@override final  String shippingMethod;
@override final  DateTime datePlaced;
@override final  DateTime? dateConfirmed;
@override final  DateTime? dateDelivered;
@override final  DateTime? dateOutForDelivery;
@override final  DateTime? dateShipped;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._orderItem, _orderItem)&&(identical(other.address, address) || other.address == address)&&(identical(other.creditCard, creditCard) || other.creditCard == creditCard)&&(identical(other.shippingMethod, shippingMethod) || other.shippingMethod == shippingMethod)&&(identical(other.datePlaced, datePlaced) || other.datePlaced == datePlaced)&&(identical(other.dateConfirmed, dateConfirmed) || other.dateConfirmed == dateConfirmed)&&(identical(other.dateDelivered, dateDelivered) || other.dateDelivered == dateDelivered)&&(identical(other.dateOutForDelivery, dateOutForDelivery) || other.dateOutForDelivery == dateOutForDelivery)&&(identical(other.dateShipped, dateShipped) || other.dateShipped == dateShipped));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_orderItem),address,creditCard,shippingMethod,datePlaced,dateConfirmed,dateDelivered,dateOutForDelivery,dateShipped);

@override
String toString() {
  return 'Order(id: $id, orderItem: $orderItem, address: $address, creditCard: $creditCard, shippingMethod: $shippingMethod, datePlaced: $datePlaced, dateConfirmed: $dateConfirmed, dateDelivered: $dateDelivered, dateOutForDelivery: $dateOutForDelivery, dateShipped: $dateShipped)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String? id, List<CartItem> orderItem, Address address, CreditCard creditCard, String shippingMethod, DateTime datePlaced, DateTime? dateConfirmed, DateTime? dateDelivered, DateTime? dateOutForDelivery, DateTime? dateShipped
});


@override $AddressCopyWith<$Res> get address;@override $CreditCardCopyWith<$Res> get creditCard;

}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? orderItem = null,Object? address = null,Object? creditCard = null,Object? shippingMethod = null,Object? datePlaced = null,Object? dateConfirmed = freezed,Object? dateDelivered = freezed,Object? dateOutForDelivery = freezed,Object? dateShipped = freezed,}) {
  return _then(_Order(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,orderItem: null == orderItem ? _self._orderItem : orderItem // ignore: cast_nullable_to_non_nullable
as List<CartItem>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,creditCard: null == creditCard ? _self.creditCard : creditCard // ignore: cast_nullable_to_non_nullable
as CreditCard,shippingMethod: null == shippingMethod ? _self.shippingMethod : shippingMethod // ignore: cast_nullable_to_non_nullable
as String,datePlaced: null == datePlaced ? _self.datePlaced : datePlaced // ignore: cast_nullable_to_non_nullable
as DateTime,dateConfirmed: freezed == dateConfirmed ? _self.dateConfirmed : dateConfirmed // ignore: cast_nullable_to_non_nullable
as DateTime?,dateDelivered: freezed == dateDelivered ? _self.dateDelivered : dateDelivered // ignore: cast_nullable_to_non_nullable
as DateTime?,dateOutForDelivery: freezed == dateOutForDelivery ? _self.dateOutForDelivery : dateOutForDelivery // ignore: cast_nullable_to_non_nullable
as DateTime?,dateShipped: freezed == dateShipped ? _self.dateShipped : dateShipped // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditCardCopyWith<$Res> get creditCard {
  
  return $CreditCardCopyWith<$Res>(_self.creditCard, (value) {
    return _then(_self.copyWith(creditCard: value));
  });
}
}

// dart format on
