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
  late List<Address> list;
  final formKey = GlobalKey<FormState>();
  bool hasBeenLoaded = false;
  @override
  void initState() {
    context.read<AddressCubit>().attemptGetAddressesCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onClick(int? index) async {
      bool isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        Address? defaultAddress;
        Address? lastAddress;
        for (Address address in list) {
          if (!address.isDefault) {
            lastAddress = address;
            await context.read<AddressCubit>().attemptUpdateAddress(
              address: address,
            );
          } else {
            defaultAddress = address;
          }
        }
        if (defaultAddress != null) {
          await context.read<AddressCubit>().attemptUpdateAddress(
            address: defaultAddress,
          );
        }

        hasBeenLoaded = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => AddAddressPage()));
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
        centerTitle: true,
        title: Text(
          'My Address',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (addresses) {
                if (!hasBeenLoaded) list = List.from(addresses);
                hasBeenLoaded = true;
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
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => Center(
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
                    icon: Icon(Icons.restart_alt),
                  ),
                ],
              ),
              orElse: () {
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
                                AddressCard(list[i], (updatedAddress) {
                                  setState(() {
                                    list[i] = updatedAddress;
                                    if (updatedAddress.isDefault) {
                                      for (int j = 0; j < list.length; j++) {
                                        if (j != i) list[j].isDefault = false;
                                      }
                                    }
                                  });
                                }),
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
