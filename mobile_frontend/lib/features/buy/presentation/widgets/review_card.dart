import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewCard extends StatelessWidget {
  Review review;
  ReviewCard(this.review, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          Row(
            spacing: 10.w,
            children: [
              CircleAvatar(
                backgroundImage: appImageProvider(review.user.imagePath),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.user.name,
                    style: Fonts.titleBold(),
                  ),
                  Text(
                    timeago.format(review.createdAt),
                    style: Fonts.paragraphMedium(size: 10),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 1.h,
          ),
          Row(
            spacing: 10.w,
            children: [
              Text(
                review.rating.toString(),
                style: Fonts.titleBold(),
              ),
              RatingBarIndicator(
                rating: review.rating, // from backend
                itemCount: 5,
                itemSize: 20.w,
                itemBuilder: ((context, index) => Icon(
                  Icons.star,
                  color: Color(0xFFFFC107),
                )),
              ),
            ],
          ),
          Text(
            review.comment,
            style: Fonts.paragraphMedium(),
          ),
        ],
      ),
    );
  }
}
