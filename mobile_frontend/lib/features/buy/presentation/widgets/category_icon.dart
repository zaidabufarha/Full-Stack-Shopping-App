import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/presentation/pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CategoryIcon extends StatelessWidget {
  Category category;
  CategoryIcon(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryPage(category)),
        );
      },
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            margin: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: category.color,
            ),
            child: Center(
              child: AppImage(
                category.imagePath,
                width: 50.w,
                height: 50.h,
              ),
            ),
          ),
          Text(category.name, style: Fonts.label()),
        ],
      ),
    );
  }
}
