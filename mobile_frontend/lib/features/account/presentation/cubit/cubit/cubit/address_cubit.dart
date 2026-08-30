import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/use_cases/add_address.dart';
import 'package:big_cart/features/account/domain/use_cases/get_addresses.dart';
import 'package:big_cart/features/account/domain/use_cases/update_address.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'address_state.dart';
part 'address_cubit.freezed.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.addAddress, this.getAddresses, this.updateAddress)
    : super(AddressState.initial());
  AddAddress addAddress;
  GetAddresses getAddresses;
  UpdateAddress updateAddress;

  void attemptAddAddress({
    required String name,
    required String address,
    required String city,
    required String country,
    required String zip,
    required String phoneNumber,
    required bool makeDefault,
  }) async {
    emit(AddressState.loading());
    final result = await addAddress(
      name: name,
      address: address,
      city: city,
      zip: zip,
      country: country,
      phoneNumber: phoneNumber,
      makeDefault: makeDefault,
    );
    result.fold(
      (failure) {
        emit(AddressState.error(failure.message));
      },
      (unit) {
        emit(AddressState.success('Added successfully'));
      },
    );
  }

  Future<void> attemptUpdateAddress({required Address address}) async {
    emit(AddressState.loading());
    final result = await updateAddress.call(address);
    result.fold(
      (failure) {
        emit(AddressState.error(failure.message));
      },
      (unit) {
        emit(AddressState.success('Updated successfully'));
      },
    );
  }

  Future<void> attemptUpdateAddresses(List<Address> addresses) async {
    if (addresses.isEmpty) return;
    emit(AddressState.loading());
    final results = await Future.wait(
      addresses.map((address) => updateAddress.call(address)),
    );
    final failure = results.where((r) => r.isLeft()).firstOrNull;
    if (failure != null) {
      failure.fold(
        (f) => emit(AddressState.error(f.message)),
        (_) {},
      );
    } else {
      emit(AddressState.success('Updated successfully'));
    }
  }

  void attemptGetAddressesCubit() async {
    emit(AddressState.loading());
    final result = await getAddresses.call();
    result.fold(
      (failure) {
        emit(AddressState.error(failure.message));
      },
      (list) {
        emit(AddressState.loaded(list));
      },
    );
  }
}
