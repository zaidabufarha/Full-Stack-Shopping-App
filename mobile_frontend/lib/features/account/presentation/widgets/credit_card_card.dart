import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CreditCardCard extends StatefulWidget {
  final CreditCard card;
  final Function(CreditCard updatedCard) onChanged;
  const CreditCardCard(this.card, this.onChanged, {super.key});

  @override
  State<CreditCardCard> createState() => _CreditCardCardState();
}

class _CreditCardCardState extends State<CreditCardCard> {
  bool isClosed = true;

  late String name;
  late String cardNumber;
  late String expiration;
  late String cvv;

  @override
  void initState() {
    name = widget.card.cardHolderName;
    cardNumber = widget.card.cardNumber;
    expiration = widget.card.expiryDate;
    cvv = widget.card.cvv;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundPrimary,
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.card.isDefault)
              ? Container(
                  color: AppColors.primaryLight,
                  child: Text(
                    'DEFAULT',
                    style: Fonts.label().copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                )
              : SizedBox(),
          Row(
            spacing: 10.w,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundTertiary,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        (widget.card.processor == PaymentProcessor.mastercard)
                            ? 'assets/mastercard.png'
                            : (widget.card.processor == PaymentProcessor.visa)
                            ? 'assets/visa.png'
                            : 'assets/paypal.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 3.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.card.processor == PaymentProcessor.mastercard)
                          ? 'Master Card'
                          : 'Visa', //no paypal card because it's external
                      style: Fonts.titleBold(),
                    ),
                    Text(
                      widget.card.cardNumber,
                      style: Fonts.paragraphRegular(size: 12),
                    ),
                    Row(
                      spacing: 10.w,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Expiry: ',
                            style: Fonts.label().copyWith(
                              color: AppColors.textPrimary,
                            ),
                            children: [
                              TextSpan(
                                text: widget.card.expiryDate,
                                style: Fonts.label().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'CVV: ',
                            style: Fonts.label().copyWith(
                              color: AppColors.textPrimary,
                            ),
                            children: [
                              TextSpan(
                                text: widget.card.cvv,
                                style: Fonts.label().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.rotate(
                //there is no identical up arrow so I'll just make my own
                angle: (!isClosed) ? 3.14159 : 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isClosed = !isClosed;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: AppColors.primaryDark,
                    size: 30.r,
                  ),
                ),
              ),
            ],
          ),
          (!isClosed)
              ? Divider(
                  thickness: 1.h,
                )
              : SizedBox(),

          (!isClosed)
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    spacing: 5.h,
                    children: [
                      TextFormField(
                        initialValue: name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
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
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          name = newValue!;
                          widget.onChanged(
                            CreditCard(
                              cardHolderName: name,
                              cardNumber: cardNumber,
                              expiryDate: expiration,
                              cvv: cvv,
                              processor: (cardNumber.startsWith('4'))
                                  ? PaymentProcessor.visa
                                  : PaymentProcessor.mastercard,
                              id: widget.card.id,
                              isDefault: widget.card.isDefault,
                            ),
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: cardNumber,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
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
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          cardNumber = newValue!;
                          widget.onChanged(
                            CreditCard(
                              cardHolderName: name,
                              cardNumber: cardNumber,
                              expiryDate: expiration,
                              cvv: cvv,
                              processor: (cardNumber.startsWith('4'))
                                  ? PaymentProcessor.visa
                                  : PaymentProcessor.mastercard,
                              id: widget.card.id,
                              isDefault: widget.card.isDefault,
                            ),
                          );
                        },
                      ),
                      Row(
                        spacing: 10.w,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: expiration,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.backgroundSecondary,
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
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                expiration = newValue!;
                                widget.onChanged(
                                  CreditCard(
                                    cardHolderName: name,
                                    cardNumber: cardNumber,
                                    expiryDate: expiration,
                                    cvv: cvv,
                                    processor: (cardNumber.startsWith('4'))
                                        ? PaymentProcessor.visa
                                        : PaymentProcessor.mastercard,
                                    id: widget.card.id,
                                    isDefault: widget.card.isDefault,
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: cvv,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.backgroundSecondary,
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
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                cvv = newValue!;
                                widget.onChanged(
                                  CreditCard(
                                    cardHolderName: name,
                                    cardNumber: cardNumber,
                                    expiryDate: expiration,
                                    cvv: cvv,
                                    processor: (cardNumber.startsWith('4'))
                                        ? PaymentProcessor.visa
                                        : PaymentProcessor.mastercard,
                                    id: widget.card.id,
                                    isDefault: widget.card.isDefault,
                                  ),
                                );
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
                                value: widget.card.isDefault,
                                title: Text(
                                  'Make default',
                                  style: Fonts.titleBold(),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                thumbColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                trackColor: WidgetStateProperty.all(
                                  (widget.card.isDefault)
                                      ? AppColors.primaryDark
                                      : AppColors.textSecondary,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                trackOutlineColor: WidgetStateColor.transparent,
                                onChanged: (val) {
                                  widget.onChanged(
                                    CreditCard(
                                      cardHolderName: name,
                                      cardNumber: cardNumber,
                                      expiryDate: expiration,
                                      cvv: cvv,
                                      processor: (cardNumber.startsWith('4'))
                                          ? PaymentProcessor.visa
                                          : PaymentProcessor.mastercard,
                                      id: widget.card.id,
                                      isDefault: val,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
