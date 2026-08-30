import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class GreenGradientButton extends StatelessWidget {
  final VoidCallback onClick;
  final Icon? icon;
  final String text;
  final bool isLoading;

  const GreenGradientButton(
    this.onClick,
    this.text, {
    this.isLoading = false,
    super.key,
  }) : icon = null;

  const GreenGradientButton.icon(
    this.onClick,
    this.text, {
    this.icon,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: AlignmentGeometry.bottomLeft,
          end: AlignmentGeometry.topRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: isLoading
          ? TextButton(
              onPressed: null,
              child: SizedBox(
                height: 24.h,
                width: 24.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            )
          : (icon == null)
              ? TextButton(
                  onPressed: onClick,
                  child: Text(
                    text,
                    style: Fonts.titleBold(
                      size: 20,
                    ).copyWith(color: Colors.white),
                  ),
                )
              : TextButton.icon(
                  onPressed: onClick,
                  icon: icon,
                  label: Text(
                    text,
                    style: Fonts.titleBold(
                      size: 20,
                    ).copyWith(color: Colors.white),
                  ),
                ),
    );
  }
}
