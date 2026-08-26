import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class BigVerticalProgressIndicator extends StatelessWidget {
  bool isFirst;
  bool isActive;
  int number;
  String label;
  bool isComplete;
  BigVerticalProgressIndicator({
    super.key,
    required this.isActive,
    required this.isFirst,
    required this.number,
    required this.label,
    required this.isComplete,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.h),
            width: 60.w,
            height: 1.h,
            color: (isFirst)
                ? Colors.transparent
                : (isActive)
                ? AppColors.primaryDark
                : Color(0xFFE8E9E9),
          ),
          Column(
            spacing: 5.h,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: (isActive)
                      ? AppColors.primaryDark
                      : AppColors.backgroundPrimary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: (isComplete)
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Text(
                          '$number',
                          style: Fonts.paragraphRegular().copyWith(
                            color: (isActive)
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                ),
              ),
              Text(
                label,
                style: Fonts.label(size: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
