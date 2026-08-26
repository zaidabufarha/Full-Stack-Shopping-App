import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/product_page.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ProductCard extends StatefulWidget {
  Product product;
  ProductCard(this.product, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder: ((context) => ProductPage(widget.product)),
          ),
        );
      },
      child: SizedBox(
        height: 300.h,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textSecondary.withAlpha(20)),
            color: AppColors.backgroundPrimary,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.product.isFavorite = !widget.product.isFavorite;
                      context.read<ShopCubit>().attemptToggleFavorite(
                        widget.product.id,
                        widget.product.isFavorite,
                      );
                    });
                  },
                  icon: Icon(
                    (widget.product.isFavorite)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  margin: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.product.color,
                  ),
                  child: Center(
                    child: AppImage(
                      widget.product.imagePath,
                      width: 100.w,
                      height: 100.h,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 120.h,
                child: SizedBox(
                  height: 200.h,
                  child: Column(
                    children: [
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: Fonts.paragraphRegular().copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        widget.product.name,
                        style: Fonts.titleBold(size: 20),
                      ),
                      Text(
                        widget.product.amount,
                        style: Fonts.paragraphRegular(),
                      ),
                      Divider(
                        thickness: 1.h,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<CartCubit>().attemptAddToCart(
                            CartItem(widget.product, 1),
                          );
                        },
                        child: Row(
                          spacing: 15.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: AppColors.primaryDark,
                            ),
                            Text(
                              'Add to cart',
                              style: Fonts.paragraphRegular(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (widget.product.isNew)
                  ? Positioned(
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        color: Color(0xFFFDEFD5),
                        child: Text(
                          'NEW',
                          style: Fonts.label().copyWith(
                            color: Color(0xFFE8AD41),
                          ),
                        ),
                      ),
                    )
                  : (widget.product.discount != 0)
                  ? Positioned(
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        color: Color(0xFFFEE4E4),
                        child: Text(
                          '-${widget.product.discount}%',
                          style: Fonts.label().copyWith(
                            color: Color(0xFFF56262),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
