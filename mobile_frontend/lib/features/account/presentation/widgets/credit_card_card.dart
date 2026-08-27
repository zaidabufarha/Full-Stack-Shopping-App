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
  late String expiration;

  @override
  void initState() {
    name = widget.card.cardHolderName;
    expiration = widget.card.expiryDate;
    super.initState();
  }

  void _notifyChange({bool? isDefault}) {
    widget.onChanged(
      CreditCard(
        id: widget.card.id,
        cardHolderName: name,
        last4: widget.card.last4,
        expiryDate: expiration,
        stripePaymentId: widget.card.stripePaymentId,
        processor: widget.card.processor,
        isDefault: isDefault ?? widget.card.isDefault,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedNumber = 'XXXX XXXX XXXX ${widget.card.last4}';

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
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  child: Text(
                    'DEFAULT',
                    style: Fonts.label().copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                )
              : const SizedBox(),
          Row(
            spacing: 10.w,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                padding: const EdgeInsets.all(10),
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
                          : 'Visa',
                      style: Fonts.titleBold(),
                    ),
                    Text(
                      formattedNumber,
                      style: Fonts.paragraphRegular(size: 12),
                    ),
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
              : const SizedBox(),

          (!isClosed)
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    spacing: 10.h,
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
                          hintText: 'Cardholder Name',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          name = newValue!.trim();
                          _notifyChange();
                        },
                      ),
                      TextFormField(
                        initialValue: formattedNumber,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary.withValues(
                            alpha: 0.5,
                          ),
                          prefixIcon: Icon(
                            Icons.credit_card_outlined,
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      TextFormField(
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
                          hintText: 'MM/YY',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          expiration = newValue!.trim();
                          _notifyChange();
                        },
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
                                contentPadding: EdgeInsets.zero,
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
                                  _notifyChange(isDefault: val);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
