import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddAddressPageState();
  }
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool saveAddress = true;
  late String name;
  late String phoneNumber;
  late String address;
  late String zip;
  late String city;
  String? country;
  String? countryError;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void onClick(int? index) {
      bool isValid = formKey.currentState!.validate();
      if (country == null) {
        setState(() {
          countryError = 'Please select a country';
        });
      } else {
        setState(() {
          countryError = null;
        });
      }
      if (isValid && country != null) {
        formKey.currentState!.save();
        context.read<AddressCubit>().attemptAddAddress(
          name: name,
          address: address,
          city: city,
          country: country!,
          zip: zip,
          phoneNumber: phoneNumber,
          makeDefault: saveAddress,
        );

        //note: remember to look into whether save address needs its own system
        //what else would add address mean if i cant save it
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),

        centerTitle: true,
        title: Text(
          'Add Address',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: BlocListener<AddressCubit, AddressState>(
        listener: (context, state) {
          state.whenOrNull(
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
              Navigator.of(context).pop();
              context.read<AddressCubit>().attemptGetAddressesCubit();
            },
          );
        },

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 10.h,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Russel Austin',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            name = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.phone_outlined,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Phone number',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            phoneNumber = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Address',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            address = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.pin_outlined,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Zip code',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            zip = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.map_outlined,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'City',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            city = newValue!;
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: false,
                                  onSelect: (Country selectedCountry) {
                                    setState(() {
                                      country = selectedCountry.name;
                                      countryError = null;
                                    });
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                color: AppColors.backgroundPrimary,
                                padding: EdgeInsets.all(10),
                                height: 56.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 12.w,
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: AppColors.textSecondary,
                                        ),
                                        Text(
                                          (country == null)
                                              ? 'Country'
                                              : country!,
                                          style: Fonts.paragraphRegular(),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.textSecondary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (countryError != null)
                              Padding(
                                padding: EdgeInsets.only(left: 12.w, top: 8.h),
                                child: Text(
                                  countryError!,
                                  style: Fonts.paragraphRegular().copyWith(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Transform.scale(
                                alignment: Alignment.centerLeft,
                                scale: 0.8,
                                child: SwitchListTile(
                                  value: saveAddress,
                                  title: Text(
                                    'Save this address',
                                    style: Fonts.titleBold(),
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  thumbColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                  trackColor: WidgetStateProperty.all(
                                    AppColors.primaryDark,
                                  ),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  trackOutlineColor:
                                      WidgetStateColor.transparent,
                                  onChanged: (save) {
                                    setState(() {
                                      saveAddress = save;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: GreenGradientButton(onClick, 'Save settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
