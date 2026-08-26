import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ShippingMethodCard extends StatefulWidget {
  final double price;
  final String title;
  final String description;
  bool isSelected;
  ShippingMethodCard({
    required this.price,
    required this.title,
    required this.description,
    required this.isSelected,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _ShippingMethodCardState();
  }
}

class _ShippingMethodCardState extends State<ShippingMethodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        border: Border.all(
          color: (widget.isSelected)
              ? AppColors.primaryDark
              : Colors.transparent,
          width: 3,
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10.w,
        children: [
          Expanded(
            child: Column(
              spacing: 10.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Fonts.titleBold(),
                ),
                Text(
                  widget.description,
                  style: Fonts.paragraphMedium(),
                ),
              ],
            ),
          ),
          Text(
            '\$${widget.price}',
            style: Fonts.paragraphRegular().copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
