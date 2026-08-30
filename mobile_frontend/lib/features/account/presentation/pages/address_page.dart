import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart';
import 'package:big_cart/features/account/presentation/pages/add_address_page.dart';
import 'package:big_cart/features/account/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddressPageState();
  }
}

class _AddressPageState extends State<AddressPage> {
  List<Address> list = [];
  List<Address> originalList = [];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AddressCubit>().attemptGetAddressesCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onClick() {
      if (formKey.currentState?.validate() ?? true) {
        final modifiedAddresses = <Address>[];
        for (int i = 0; i < list.length; i++) {
          final current = list[i];
          final original = i < originalList.length ? originalList[i] : null;
          if (original == null || current != original) {
            modifiedAddresses.add(current);
          }
        }

        if (modifiedAddresses.isNotEmpty) {
          context.read<AddressCubit>().attemptUpdateAddresses(modifiedAddresses);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const AddAddressPage()));
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
        centerTitle: true,
        title: Text(
          'My Address',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (addresses) {
                list = addresses.map((a) => a.copyWith()).toList();
                originalList = addresses.map((a) => a.copyWith()).toList();
              },
              error: (message) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: Fonts.paragraphMedium().copyWith(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              success: (message) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: Fonts.paragraphMedium().copyWith(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppColors.primaryDark,
                  ),
                );
                context.read<AddressCubit>().attemptGetAddressesCubit();
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (message) => Column(
                children: [
                  Text(message, style: Fonts.titleBold()),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AddressCubit>().attemptGetAddressesCubit();
                    },
                    label: Text(
                      'Retry',
                      style: Fonts.paragraphMedium(),
                    ),
                    icon: const Icon(Icons.restart_alt),
                  ),
                ],
              ),
              orElse: () {
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'No addresses found',
                      style: Fonts.titleBold(),
                    ),
                  );
                }
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 10.h,
                            children: [
                              for (int i = 0; i < list.length; i++)
                                AddressCard(
                                  key: ValueKey(list[i].id ?? '$i'),
                                  list[i],
                                  (updatedAddress) {
                                    setState(() {
                                      if (updatedAddress.isDefault) {
                                        list = [
                                          for (int j = 0; j < list.length; j++)
                                            if (j == i)
                                              updatedAddress
                                            else
                                              list[j].copyWith(isDefault: false),
                                        ];
                                      } else {
                                        list = [
                                          for (int j = 0; j < list.length; j++)
                                            if (j == i)
                                              updatedAddress
                                            else
                                              list[j],
                                        ];
                                      }
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      GreenGradientButton(onClick, 'Save settings'),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
