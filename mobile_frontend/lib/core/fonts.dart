import 'package:big_cart/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Fonts {
  static TextStyle titleBold({double size = 15}) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: size.sp,
  );

  static TextStyle paragraphRegular({double size = 15}) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: size.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle paragraphMedium({double size = 12}) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: size.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle label({double size = 12}) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: size.sp,
    color: AppColors.textSecondary,
  );
}
//MAKE FONTS LOCAL IN THE ASSETS FOLDER