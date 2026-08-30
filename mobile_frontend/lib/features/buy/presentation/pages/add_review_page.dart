import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AddReviewPage extends StatefulWidget {
  AddReviewPage(this.id, {super.key});
  String id;

  @override
  State<StatefulWidget> createState() {
    return _AddReviewPageState();
  }
}

class _AddReviewPageState extends State<AddReviewPage> {
  String review = '';
  double rating = 5;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void onClick() {
      formKey.currentState!.save();
      context.read<ShopCubit>().attemptAddReview(widget.id, review, rating);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Reviews',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: BlocConsumer<ShopCubit, ShopState>(
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
              context.read<ShopCubit>().attemptGetProductReviews(widget.id);
              context.read<ShopCubit>().attemptGetProductList();
              Navigator.of(context).pop();
            },
          );
        },
        builder: (context, state) => state.maybeWhen(
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          orElse: () => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20.h,

                      children: [
                        Text(
                          'What do you think?',
                          style: Fonts.titleBold(size: 20),
                        ),
                        Text(
                          'Please rate this product by clicking on the stars below',
                          textAlign: TextAlign.center,
                          style: Fonts.paragraphRegular(),
                        ),
                        RatingBar.builder(
                          initialRating: 5,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (newRating) {
                            rating = newRating;
                          },
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              maxLines: null,
                              minLines: 4,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.backgroundPrimary,
                                prefixIcon: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.transparent,
                                ),
                                hint: Text(
                                  'Tell us your experience',
                                  style: Fonts.paragraphRegular(),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),

                              onSaved: (newValue) {
                                review = newValue ?? '';
                              },
                            ),

                            Positioned(
                              top: 15.h,
                              left: 15.w,
                              child: Icon(
                                Icons.edit,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GreenGradientButton(onClick, 'Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
