import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddCreditCardPageState();
  }
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  bool saveCard = true;
  late String name;
  late String cardNumber;
  late String expiration;
  String cvv = '';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void onClick() {
      bool isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        context.read<CardsCubit>().attemptAddCreditCard(
          name: name,
          cardNumber: cardNumber,
          expiration: expiration,
          saveCard: saveCard,
          processor: (cardNumber.startsWith('4'))
              ? PaymentProcessor.visa
              : PaymentProcessor.mastercard,
        );
      }
    }

    return BlocConsumer<CardsCubit, CardsState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: Fonts.paragraphMedium().copyWith(color: Colors.white),
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
                  style: Fonts.paragraphMedium().copyWith(color: Colors.white),
                ),
                backgroundColor: AppColors.primaryDark,
              ),
            );
            context.read<CardsCubit>().attemptGetCreditCards();
            Navigator.of(context).pop();
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => Scaffold(
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
                'Add Credit Card',
                style: Fonts.titleBold(size: 20),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          orElse: () => Scaffold(
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
                'Add Credit Card',
                style: Fonts.titleBold(size: 20),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 10.h,
                        children: [
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
                              name = newValue!;
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
                              cardNumber = newValue!;
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
                                    fillColor: AppColors.backgroundPrimary,
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
                                    if (value == null || value.isEmpty) {
                                      return 'Cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    expiration = newValue!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.backgroundPrimary,
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
                                    if (value == null || value.isEmpty) {
                                      return 'Cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    cvv = newValue!;
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
                                    value: saveCard,
                                    title: Text(
                                      'Set as default',
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
                                        saveCard = save;
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

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GreenGradientButton(onClick, 'Save settings'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
