import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class FilterCard extends StatelessWidget {
  bool isActive;
  String label;
  IconData icon;
  FilterCard({
    required this.isActive,
    required this.label,
    required this.icon,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            spacing: 10.w,
            children: [
              Icon(
                icon,
                color: AppColors.textSecondary,
              ),
              Text(
                label,
                style: Fonts.paragraphRegular(),
              ),
            ],
          ),
        ),
        Icon(
          Icons.check_circle_outline,
          color: (isActive) ? AppColors.primaryDark : AppColors.textSecondary,
        ),
      ],
    );
  }
}
