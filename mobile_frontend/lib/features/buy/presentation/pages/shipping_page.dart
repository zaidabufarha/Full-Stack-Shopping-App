import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart';
import 'package:big_cart/features/account/presentation/widgets/big_vertical_progress_indicator.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/payment_card.dart';
import 'package:big_cart/features/buy/presentation/widgets/shipping_method_card.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ShippingPage extends StatefulWidget {
  final List<CartItem> list;
  const ShippingPage(this.list, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShippingPageState();
  }
}

class _ShippingPageState extends State<ShippingPage> {
  int step = 1;

  bool saveCard = false;

  final formKey = GlobalKey<FormState>();

  String selectedShippingMethod = 'Standard Delivery';

  late String addressName;
  late String addressEmail;
  late String addressNumber;
  late String addressAddress; //bad name
  late String addressZip;
  late String addressCity;
  String addressCountry = 'Country';
  bool addressSave = false;
  late String creditCardName;
  late String creditCardNumber;
  late String creditCardExpiration;
  late String creditCardCVV;
  bool creditCardSave = false;

  late Address address;
  late CreditCard creditCard;
  late Order order;

  @override
  Widget build(BuildContext context) {
    void onClick(int? index) {
      setState(() {
        if (step == 2) {
          bool isValid = formKey.currentState!.validate();
          if (isValid) {
            formKey.currentState!.save();
            address = Address(
              name: addressName,
              street: addressAddress,
              city: addressCity,
              country: addressCountry,
              phone: addressNumber,
              zipCode: addressZip,
            );
            step++;
            if (addressSave) {
              context.read<AddressCubit>().attemptAddAddress(
                name: addressName,
                address: addressAddress,
                city: addressCity,
                country: addressCountry,
                zip: addressZip,
                phoneNumber: addressNumber,
                makeDefault: false,
              );
            }
          }
        } else if (step == 3) {
          {
            bool isValid = formKey.currentState!.validate();
            if (isValid) {
              formKey.currentState!.save();
              final cleanNum = creditCardNumber.replaceAll(RegExp(r'\s+'), '');
              final last4 = cleanNum.length >= 4
                  ? cleanNum.substring(cleanNum.length - 4)
                  : cleanNum;
              creditCard = CreditCard(
                cardHolderName: creditCardName,
                last4: last4,
                expiryDate: creditCardExpiration,
                processor: (cleanNum.startsWith('4')
                    ? PaymentProcessor.visa
                    : PaymentProcessor.mastercard),
              );
              if (creditCardSave) {
                context.read<CardsCubit>().attemptAddCreditCard(
                  name: creditCardName,
                  cardNumber: cleanNum,
                  expiration: creditCardExpiration,
                  saveCard: false,
                  processor: (cleanNum.startsWith('4')
                      ? PaymentProcessor.visa
                      : PaymentProcessor.mastercard),
                );
              }
              order = Order(
                orderItem: widget.list,
                createdAt: DateTime.now(),
                address: address,
                creditCard: creditCard,
                shippingMethod: selectedShippingMethod,
              );
              context.read<CartCubit>().attemptCheckOut(order);
            }
          }
        } else {
          step++; //for step 1
        }
      });
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
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          state.whenOrNull(
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
              ScaffoldMessenger.of(context).showSnackBar(
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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false,
              );
            },
          );
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        BigVerticalProgressIndicator(
                          isActive: true,
                          isFirst: true,
                          number: 1,
                          label: 'PAYMENT',
                          isComplete: (step == 1) ? false : true,
                        ),
                        BigVerticalProgressIndicator(
                          isActive: (step >= 2),
                          isFirst: false,
                          number: 2,
                          label: 'PAYMENT',
                          isComplete: (step > 2) ? true : false,
                        ),
                        BigVerticalProgressIndicator(
                          isActive: (step > 2),
                          isFirst: false,
                          number: 3,
                          label: 'PAYMENT',
                          isComplete: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: (step == 1)
                            ? Column(
                                spacing: 10.h,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedShippingMethod =
                                            'Standard Delivery';
                                      });
                                    },
                                    child: ShippingMethodCard(
                                      isSelected:
                                          (selectedShippingMethod ==
                                          'Standard Delivery'),
                                      price: 3,
                                      title: 'Standard Delivery',
                                      description:
                                          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedShippingMethod =
                                            'Next Day Delivery';
                                      });
                                    },
                                    child: ShippingMethodCard(
                                      isSelected:
                                          (selectedShippingMethod ==
                                          'Next Day Delivery'),
                                      price: 3,
                                      title: 'Next Day Delivery',
                                      description:
                                          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedShippingMethod =
                                            'Nominated Delivery';
                                      });
                                    },
                                    child: ShippingMethodCard(
                                      isSelected:
                                          (selectedShippingMethod ==
                                          'Nominated Delivery'),
                                      price: 3,
                                      title: 'Nominated Delivery',
                                      description:
                                          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
                                    ),
                                  ),
                                ],
                              )
                            : (step == 2)
                            ? Column(
                                spacing: 5.h,
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
                                      addressName = newValue!;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.mail_outline,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'Email address',
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
                                      addressEmail = newValue!;
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
                                      addressNumber = newValue!;
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
                                      addressAddress = newValue!;
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
                                      addressZip = newValue!;
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
                                      if (value == null ||
                                          value.isEmpty ||
                                          addressCountry == 'Country') {
                                        return 'City and country cannot be empty';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      addressCity = newValue!;
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode: false,
                                        onSelect: (Country country) {
                                          setState(() {
                                            addressCountry = country.name;
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
                                                addressCountry,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Transform.scale(
                                          alignment: Alignment.centerLeft,
                                          scale: 0.8,
                                          child: SwitchListTile(
                                            value: addressSave,
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
                                              (addressSave)
                                                  ? AppColors.primaryDark
                                                  : AppColors.textSecondary,
                                            ),
                                            dense: true,
                                            visualDensity:
                                                VisualDensity.compact,
                                            trackOutlineColor:
                                                WidgetStateColor.transparent,
                                            onChanged: (isDefault) {
                                              setState(() {
                                                addressSave = isDefault;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                spacing: 5.h,
                                children: [
                                  Row(
                                    children: [
                                      PaymentCard(
                                        path: 'assets/paypal_grey.svg',
                                        text: 'Paypal',
                                      ),
                                      PaymentCard(
                                        path: 'assets/card_grey.svg',
                                        text: 'Credit Card',
                                      ),
                                      PaymentCard(
                                        path: 'assets/apple_grey.svg',
                                        text: 'Apple Pay',
                                      ),
                                    ],
                                  ),

                                  Image.asset(
                                    'assets/card_picture.png',
                                  ),
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
                                      creditCardName = newValue!;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.credit_card_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'XXXX XXXX XXXX 5678',
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
                                      creditCardNumber = newValue!;
                                    },
                                  ),
                                  Row(
                                    spacing: 10.w,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                AppColors.backgroundPrimary,
                                            prefixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: AppColors.textSecondary,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            hint: Text(
                                              '01/22',
                                              style: Fonts.paragraphRegular(),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Cannot be empty';
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            creditCardExpiration = newValue!;
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                AppColors.backgroundPrimary,
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                              color: AppColors.textSecondary,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            hint: Text(
                                              '908',
                                              style: Fonts.paragraphRegular(),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Cannot be empty';
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            creditCardCVV = newValue!;
                                          },
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
                                            value: creditCardSave,
                                            title: Text(
                                              'Save card',
                                              style: Fonts.titleBold(),
                                            ),
                                            contentPadding: EdgeInsets.all(0),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            thumbColor: WidgetStateProperty.all(
                                              Colors.white,
                                            ),
                                            trackColor: WidgetStateProperty.all(
                                              (creditCardSave)
                                                  ? AppColors.primaryDark
                                                  : AppColors.textSecondary,
                                            ),
                                            dense: true,
                                            visualDensity:
                                                VisualDensity.compact,
                                            trackOutlineColor:
                                                WidgetStateColor.transparent,
                                            onChanged: (save) {
                                              setState(() {
                                                creditCardSave = save;
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
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: GreenGradientButton(
                  onClick,
                  (step == 3) ? 'Make a payment' : 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
