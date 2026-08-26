import 'package:big_cart/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class BigOrderProgressIndicator extends StatelessWidget {
  bool isFirst;
  bool isActive;
  Icon icon;
  BigOrderProgressIndicator({
    super.key,
    required this.isActive,
    required this.isFirst,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 60.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 28.w),
            width: 1.w,
            height: 40.h,
            color: (isFirst) ? Colors.transparent : Color(0xFFEBEBEB),
          ),
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: (isActive)
                  ? AppColors.primaryLight
                  : AppColors.backgroundTertiary,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
        ],
      ),
    );
  }
}
