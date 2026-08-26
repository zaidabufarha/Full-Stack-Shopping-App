import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/add_review_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ReviewPage extends StatefulWidget {
  final Product product;
  const ReviewPage(this.product, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReviewPageState();
  }
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    context.read<ShopCubit>().attemptGetProductReviews(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(
                MaterialPageRoute(
                  builder: (context) => AddReviewPage(widget.product.id),
                ),
              );
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Reviews',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: Fonts.paragraphMedium().copyWith(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              success: (message) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: Fonts.paragraphMedium().copyWith(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppColors.primaryDark,
                  ),
                );
                context.read<ShopCubit>().attemptGetProductReviews(
                  widget.product.id,
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loadedReviews: (reviewList) => (reviewList.isNotEmpty)
                  ? SingleChildScrollView(
                      child: Column(
                        spacing: 10.h,

                        children: [
                          for (Review review in reviewList) ReviewCard(review),
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        'No reviews have been submitted yet. Use the top right button to be the first.',
                        style: Fonts.titleBold(),
                      ),
                    ),
              orElse: () => Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
