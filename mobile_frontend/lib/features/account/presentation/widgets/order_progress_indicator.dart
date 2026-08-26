import 'package:big_cart/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class OrderProgressIndicator extends StatelessWidget {
  bool isFirst;
  bool isActive;
  OrderProgressIndicator({
    super.key,
    required this.isActive,
    required this.isFirst,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 20.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 9.w),
            width: 1.w,
            height: 20.h,
            color: (isFirst)
                ? Colors.transparent
                : (isActive)
                ? AppColors.primaryDark
                : Color(0xFFEBEBEB),
          ),
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: (isActive) ? AppColors.primaryDark : Color(0xFFEBEBEB),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
