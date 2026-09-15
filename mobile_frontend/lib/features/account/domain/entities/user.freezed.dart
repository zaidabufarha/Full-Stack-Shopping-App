// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$User {

 String get name; String get email; String get phone; String get password; String get imagePath; Address? get defaultAddress; List<CreditCard> get creditCard; List<Address> get address; List<Order> get order; List<Transaction> get transaction;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&const DeepCollectionEquality().equals(other.creditCard, creditCard)&&const DeepCollectionEquality().equals(other.address, address)&&const DeepCollectionEquality().equals(other.order, order)&&const DeepCollectionEquality().equals(other.transaction, transaction));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,phone,password,imagePath,defaultAddress,const DeepCollectionEquality().hash(creditCard),const DeepCollectionEquality().hash(address),const DeepCollectionEquality().hash(order),const DeepCollectionEquality().hash(transaction));

@override
String toString() {
  return 'User(name: $name, email: $email, phone: $phone, password: $password, imagePath: $imagePath, defaultAddress: $defaultAddress, creditCard: $creditCard, address: $address, order: $order, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String name, String email, String phone, String password, String imagePath, Address? defaultAddress, List<CreditCard> creditCard, List<Address> address, List<Order> order, List<Transaction> transaction
});


$AddressCopyWith<$Res>? get defaultAddress;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? password = null,Object? imagePath = null,Object? defaultAddress = freezed,Object? creditCard = null,Object? address = null,Object? order = null,Object? transaction = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as Address?,creditCard: null == creditCard ? _self.creditCard : creditCard // ignore: cast_nullable_to_non_nullable
as List<CreditCard>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as List<Address>,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as List<Order>,transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as List<Transaction>,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get defaultAddress {
    if (_self.defaultAddress == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.defaultAddress!, (value) {
    return _then(_self.copyWith(defaultAddress: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String phone,  String password,  String imagePath,  Address? defaultAddress,  List<CreditCard> creditCard,  List<Address> address,  List<Order> order,  List<Transaction> transaction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.password,_that.imagePath,_that.defaultAddress,_that.creditCard,_that.address,_that.order,_that.transaction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String phone,  String password,  String imagePath,  Address? defaultAddress,  List<CreditCard> creditCard,  List<Address> address,  List<Order> order,  List<Transaction> transaction)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.name,_that.email,_that.phone,_that.password,_that.imagePath,_that.defaultAddress,_that.creditCard,_that.address,_that.order,_that.transaction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String phone,  String password,  String imagePath,  Address? defaultAddress,  List<CreditCard> creditCard,  List<Address> address,  List<Order> order,  List<Transaction> transaction)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.password,_that.imagePath,_that.defaultAddress,_that.creditCard,_that.address,_that.order,_that.transaction);case _:
  return null;

}
}

}

/// @nodoc


class _User implements User {
  const _User({required this.name, required this.email, required this.phone, this.password = '', this.imagePath = 'assets/blank_profile_picture.png', this.defaultAddress, final  List<CreditCard> creditCard = const [], final  List<Address> address = const [], final  List<Order> order = const [], final  List<Transaction> transaction = const []}): _creditCard = creditCard,_address = address,_order = order,_transaction = transaction;
  

@override final  String name;
@override final  String email;
@override final  String phone;
@override@JsonKey() final  String password;
@override@JsonKey() final  String imagePath;
@override final  Address? defaultAddress;
 final  List<CreditCard> _creditCard;
@override@JsonKey() List<CreditCard> get creditCard {
  if (_creditCard is EqualUnmodifiableListView) return _creditCard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_creditCard);
}

 final  List<Address> _address;
@override@JsonKey() List<Address> get address {
  if (_address is EqualUnmodifiableListView) return _address;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_address);
}

 final  List<Order> _order;
@override@JsonKey() List<Order> get order {
  if (_order is EqualUnmodifiableListView) return _order;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_order);
}

 final  List<Transaction> _transaction;
@override@JsonKey() List<Transaction> get transaction {
  if (_transaction is EqualUnmodifiableListView) return _transaction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transaction);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&const DeepCollectionEquality().equals(other._creditCard, _creditCard)&&const DeepCollectionEquality().equals(other._address, _address)&&const DeepCollectionEquality().equals(other._order, _order)&&const DeepCollectionEquality().equals(other._transaction, _transaction));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,phone,password,imagePath,defaultAddress,const DeepCollectionEquality().hash(_creditCard),const DeepCollectionEquality().hash(_address),const DeepCollectionEquality().hash(_order),const DeepCollectionEquality().hash(_transaction));

@override
String toString() {
  return 'User(name: $name, email: $email, phone: $phone, password: $password, imagePath: $imagePath, defaultAddress: $defaultAddress, creditCard: $creditCard, address: $address, order: $order, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String phone, String password, String imagePath, Address? defaultAddress, List<CreditCard> creditCard, List<Address> address, List<Order> order, List<Transaction> transaction
});


@override $AddressCopyWith<$Res>? get defaultAddress;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? password = null,Object? imagePath = null,Object? defaultAddress = freezed,Object? creditCard = null,Object? address = null,Object? order = null,Object? transaction = null,}) {
  return _then(_User(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as Address?,creditCard: null == creditCard ? _self._creditCard : creditCard // ignore: cast_nullable_to_non_nullable
as List<CreditCard>,address: null == address ? _self._address : address // ignore: cast_nullable_to_non_nullable
as List<Address>,order: null == order ? _self._order : order // ignore: cast_nullable_to_non_nullable
as List<Order>,transaction: null == transaction ? _self._transaction : transaction // ignore: cast_nullable_to_non_nullable
as List<Transaction>,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get defaultAddress {
    if (_self.defaultAddress == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.defaultAddress!, (value) {
    return _then(_self.copyWith(defaultAddress: value));
  });
}
}

// dart format on
