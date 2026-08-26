import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';

class PaymentCard extends StatelessWidget {
  String path;
  String text;
  PaymentCard({required this.path, required this.text, super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: AppColors.backgroundPrimary,
        width: 100.w,
        height: 100.w, //so it can be a square
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15.h,
          children: [
            SvgPicture.asset(
              path,
              width: 20.w,
              height: 20.w,
              fit: BoxFit.contain,
            ),
            Text(
              text,
              style: Fonts.label(size: 8),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
