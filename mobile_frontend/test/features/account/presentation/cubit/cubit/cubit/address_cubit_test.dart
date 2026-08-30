import 'package:big_cart/features/account/domain/use_cases/add_address.dart';
import 'package:big_cart/features/account/domain/use_cases/get_addresses.dart';
import 'package:big_cart/features/account/domain/use_cases/update_address.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../helpers/test_fixtures.dart';

class MockAddAddress extends Mock implements AddAddress {}

class MockGetAddresses extends Mock implements GetAddresses {}

class MockUpdateAddress extends Mock implements UpdateAddress {}

void main() {
  late MockAddAddress mockAddAddress;
  late MockGetAddresses mockGetAddresses;
  late MockUpdateAddress mockUpdateAddress;
  late AddressCubit addressCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockAddAddress = MockAddAddress();
    mockGetAddresses = MockGetAddresses();
    mockUpdateAddress = MockUpdateAddress();

    addressCubit = AddressCubit(
      mockAddAddress,
      mockGetAddresses,
      mockUpdateAddress,
    );
  });

  tearDown(() {
    addressCubit.close();
  });

  test('initial state is AddressState.initial()', () {
    expect(addressCubit.state, const AddressState.initial());
  });

  group('attemptAddAddress', () {
    blocTest<AddressCubit, AddressState>(
      'emits [loading, success] when address added successfully',
      build: () {
        when(
          () => mockAddAddress.call(
            name: any(named: 'name'),
            address: any(named: 'address'),
            city: any(named: 'city'),
            zip: any(named: 'zip'),
            country: any(named: 'country'),
            phoneNumber: any(named: 'phoneNumber'),
            makeDefault: any(named: 'makeDefault'),
          ),
        ).thenAnswer((_) async => const Right(unit));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptAddAddress(
        name: 'Home',
        address: '123 Main St',
        city: 'Springfield',
        country: 'USA',
        zip: '12345',
        phoneNumber: '+1234567890',
        makeDefault: true,
      ),
      expect: () => [
        const AddressState.loading(),
        const AddressState.success('Added successfully'),
      ],
      verify: (_) {
        verify(
          () => mockAddAddress.call(
            name: 'Home',
            address: '123 Main St',
            city: 'Springfield',
            country: 'USA',
            zip: '12345',
            phoneNumber: '+1234567890',
            makeDefault: true,
          ),
        ).called(1);
      },
    );

    blocTest<AddressCubit, AddressState>(
      'emits [loading, error] when add address fails',
      build: () {
        when(
          () => mockAddAddress.call(
            name: any(named: 'name'),
            address: any(named: 'address'),
            city: any(named: 'city'),
            zip: any(named: 'zip'),
            country: any(named: 'country'),
            phoneNumber: any(named: 'phoneNumber'),
            makeDefault: any(named: 'makeDefault'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Failed to add address')));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptAddAddress(
        name: 'Home',
        address: '123 Main St',
        city: 'Springfield',
        country: 'USA',
        zip: '12345',
        phoneNumber: '+1234567890',
        makeDefault: false,
      ),
      expect: () => [
        const AddressState.loading(),
        const AddressState.error('Failed to add address'),
      ],
    );
  });

  group('attemptUpdateAddress', () {
    blocTest<AddressCubit, AddressState>(
      'emits [loading, success] when address updated successfully',
      build: () {
        when(
          () => mockUpdateAddress.call(any()),
        ).thenAnswer((_) async => const Right(unit));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptUpdateAddress(address: testAddress),
      expect: () => [
        const AddressState.loading(),
        const AddressState.success('Updated successfully'),
      ],
      verify: (_) {
        verify(() => mockUpdateAddress.call(testAddress)).called(1);
      },
    );

    blocTest<AddressCubit, AddressState>(
      'emits [loading, error] when update address fails',
      build: () {
        when(
          () => mockUpdateAddress.call(any()),
        ).thenAnswer((_) async => Left(DummyFailure('Update address failed')));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptUpdateAddress(address: testAddress),
      expect: () => [
        const AddressState.loading(),
        const AddressState.error('Update address failed'),
      ],
    );
  });

  group('attemptUpdateAddresses', () {
    blocTest<AddressCubit, AddressState>(
      'emits [loading, success] when all addresses updated successfully',
      build: () {
        when(
          () => mockUpdateAddress.call(any()),
        ).thenAnswer((_) async => const Right(unit));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptUpdateAddresses([testAddress]),
      expect: () => [
        const AddressState.loading(),
        const AddressState.success('Updated successfully'),
      ],
      verify: (_) {
        verify(() => mockUpdateAddress.call(testAddress)).called(1);
      },
    );

    blocTest<AddressCubit, AddressState>(
      'emits [loading, error] when any update address fails',
      build: () {
        when(
          () => mockUpdateAddress.call(any()),
        ).thenAnswer((_) async => Left(DummyFailure('Batch update failed')));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptUpdateAddresses([testAddress]),
      expect: () => [
        const AddressState.loading(),
        const AddressState.error('Batch update failed'),
      ],
    );

    blocTest<AddressCubit, AddressState>(
      'emits nothing when addresses list is empty',
      build: () => addressCubit,
      act: (cubit) => cubit.attemptUpdateAddresses([]),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockUpdateAddress.call(any()));
      },
    );
  });

  group('attemptGetAddressesCubit', () {
    blocTest<AddressCubit, AddressState>(
      'emits [loading, loaded] when fetching addresses succeeds',
      build: () {
        when(
          () => mockGetAddresses.call(),
        ).thenAnswer((_) async => Right([testAddress]));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptGetAddressesCubit(),
      expect: () => [
        const AddressState.loading(),
        AddressState.loaded([testAddress]),
      ],
      verify: (_) {
        verify(() => mockGetAddresses.call()).called(1);
      },
    );

    blocTest<AddressCubit, AddressState>(
      'emits [loading, error] when fetching addresses fails',
      build: () {
        when(
          () => mockGetAddresses.call(),
        ).thenAnswer((_) async => Left(DummyFailure('Fetch failed')));
        return addressCubit;
      },
      act: (cubit) => cubit.attemptGetAddressesCubit(),
      expect: () => [
        const AddressState.loading(),
        const AddressState.error('Fetch failed'),
      ],
    );
  });
}
