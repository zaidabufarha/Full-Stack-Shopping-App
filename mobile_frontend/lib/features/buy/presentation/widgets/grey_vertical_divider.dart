import 'package:big_cart/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class GreyVerticalDivider extends StatelessWidget {
  const GreyVerticalDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 1.w,
      color: AppColors.textSecondary.withAlpha(128),
    );
  }
}
