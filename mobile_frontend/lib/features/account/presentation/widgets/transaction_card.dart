import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TransactionCard extends StatelessWidget {
  Transaction transaction;
  TransactionCard(this.transaction, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppColors.backgroundPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary,
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    (transaction.paymentMethod == PaymentProcessor.mastercard)
                        ? 'assets/mastercard.png'
                        : (transaction.paymentMethod == PaymentProcessor.visa)
                        ? 'assets/visa.png'
                        : 'assets/paypal.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (transaction.paymentMethod == PaymentProcessor.mastercard)
                    ? 'Master Card'
                    : (transaction.paymentMethod == PaymentProcessor.visa)
                    ? 'Visa'
                    : 'Paypal',
                style: Fonts.titleBold(),
              ),
              Text(
                'Dec 12 2021 at 10:00pm',
                style: Fonts.label(),
              ),
            ],
          ),
          SizedBox(
            width: 40.w,
          ),
          Text(
            '\$${transaction.amount}',
            style: Fonts.titleBold().copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
