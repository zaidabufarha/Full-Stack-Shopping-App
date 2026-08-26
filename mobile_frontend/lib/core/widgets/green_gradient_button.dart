import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class GreenGradientButton extends StatelessWidget {
  final void Function(int? index) onClick;
  final int? index;
  final Icon? icon;
  final String text;

  const GreenGradientButton(
    this.onClick,
    this.text, {
    super.key,
  }) : index = null,
       icon = null;

  const GreenGradientButton.icon(
    this.onClick,
    this.text, {
    this.icon,
    super.key,
  }) : index = null;

  const GreenGradientButton.index(
    this.onClick,
    this.index,
    this.text, {
    super.key,
  }) : icon = null;
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
      child: (icon == null)
          ? TextButton(
              onPressed: () {
                (index == null) ? onClick(null) : onClick(index!);
              },
              child: Text(
                text,
                style: Fonts.titleBold(
                  size: 20,
                ).copyWith(color: Colors.white),
              ),
            )
          : TextButton.icon(
              onPressed: () {
                (index == null) ? onClick(null) : onClick(index!);
              },
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
