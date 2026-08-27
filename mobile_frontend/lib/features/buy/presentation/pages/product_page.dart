import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/add_review_page.dart';
import 'package:big_cart/features/buy/presentation/pages/review_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/grey_vertical_divider.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage(this.product, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;
  late bool isFavorite;
  late Product product;
  @override
  void initState() {
    product = widget.product;
    isFavorite = widget.product.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sumOfRatings = 0;
    for (int i = 0; i < product.review.length; i++) {
      sumOfRatings += product.review[i].rating;
    }
    double averageRating = -1;
    if (product.review.isNotEmpty) {
      averageRating = sumOfRatings / product.review.length;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: WidgetStateColor.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: widget.product.color,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ShopCubit, ShopState>(
            listener: (context, state) {
              state.whenOrNull(
                loadedProducts: (products) {
                  //we want to get the product without needing to pop to home
                  setState(() {
                    product = products.firstWhere(
                      (product) => product.id == widget.product.id,
                      orElse: () => widget.product,
                    );
                  });
                },
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
                  Navigator.of(context).pop();
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
                },
              );
            },
          ),
          BlocListener<CartCubit, CartState>(
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
                },
              );
            },
          ),
        ],
        child: Stack(
          children: [
            SizedBox.expand(
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 370.h,
                    top: 0,
                    child: AppImage(
                      product.imagePath,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    height: 420.h,
                    bottom: 0.h,
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: Fonts.titleBold(size: 25).copyWith(
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                  context
                                      .read<ShopCubit>()
                                      .attemptToggleFavorite(
                                        product.id,
                                        !isFavorite,
                                      );
                                },
                                icon: Icon(
                                  (isFavorite)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: (isFavorite)
                                      ? Colors.red
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            product.name,
                            style: Fonts.titleBold(
                              size: 30,
                            ).copyWith(color: AppColors.textPrimary),
                          ),
                          Text(
                            product.amount,
                            style: Fonts.paragraphRegular(),
                          ),
                          (averageRating != -1)
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReviewPage(product),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    spacing: 5.w,
                                    children: [
                                      Text(
                                        averageRating.toStringAsFixed(1),
                                        style: Fonts.paragraphRegular()
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                      RatingBarIndicator(
                                        rating: averageRating,
                                        itemCount: 5,
                                        itemSize: 30.w,
                                        itemBuilder: ((context, index) => Icon(
                                          Icons.star,
                                          color: Color(0xFFFFC107),
                                        )),
                                      ),
                                      Text(
                                        '(${product.review.length.toString()} review${(product.review.length > 1) ? 's)' : ')'}',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ],
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddReviewPage(product.id),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'No reviews yet. Add your own?',
                                    style: Fonts.paragraphRegular().copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                          Text(
                            product.description,
                            maxLines: 5,
                            style: Fonts.paragraphRegular(),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.r),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10.w,
                              children: [
                                Text(
                                  'Quantity',
                                  style: Fonts.titleBold(size: 20),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 20.w,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (quantity > 1) {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: (quantity > 1)
                                            ? AppColors.primaryDark
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                    GreyVerticalDivider(),
                                    Text(
                                      quantity.toString(),
                                      style: Fonts.titleBold(size: 20),
                                    ),
                                    GreyVerticalDivider(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //making this work with the green button would need a different constructor and conditions because the icon is on the right so for now ill just reuse some code
                          Container(
                            height: 70.h,
                            padding: EdgeInsets.all(10.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.primaryDark,
                                ],
                                begin: AlignmentGeometry.bottomLeft,
                                end: AlignmentGeometry.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: TextButton(
                              onPressed: () {
                                final newItem = CartItem(
                                  product,
                                  quantity,
                                );
                                context.read<CartCubit>().attemptAddToCart(
                                  newItem,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Text(
                                    'Add to cart',
                                    style: Fonts.titleBold(size: 20).copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
