import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartCard extends StatefulWidget {
  final CartItem data;
  final bool isFavorites;
  const CartCard(this.data, {this.isFavorites = false, super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartCardState();
  }
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.data.product.name),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          CustomSlidableAction(
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            child: Icon(
              Icons.delete,
              size: 30.r,
            ),
            onPressed: (BuildContext context) {
              if (widget.isFavorites) {
                context.read<ShopCubit>().attemptToggleFavorite(
                  widget.data.product.id,
                  false,
                );
              } else {
                context.read<CartCubit>().attemptRemoveFromCart(widget.data);
              }
            },
          ),
        ],
      ),
      child: Container(
        color: AppColors.backgroundPrimary,
        padding: EdgeInsets.all(5),
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              margin: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.data.product.color,
              ),
              child: Center(
                child: AppImage(
                  widget.data.product.imagePath,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${widget.data.product.price} x ${widget.data.quantity}',
                    style: Fonts.paragraphMedium().copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    widget.data.product.name,
                    style: Fonts.titleBold(),
                  ),
                  Text(
                    widget.data.product.amount,
                    style: Fonts.paragraphMedium(),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      context.read<CartCubit>().attemptUpdateQuantity(
                        widget.data,
                        widget.data.quantity += 1,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: AppColors.primaryDark,
                  ),
                ),
                Text(
                  widget.data.quantity.toString(),
                  style: Fonts.paragraphRegular(),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.data.quantity > 1) {
                        context.read<CartCubit>().attemptUpdateQuantity(
                          widget.data,
                          widget.data.quantity - 1,
                        );
                      } else {
                        setState(() {
                          if (widget.isFavorites) {
                            context.read<ShopCubit>().attemptToggleFavorite(
                              widget.data.product.id,
                              false,
                            );
                          } else {
                            context.read<CartCubit>().attemptRemoveFromCart(
                              widget.data,
                            );
                          }
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.remove,
                    color: (widget.data.quantity > 1)
                        ? AppColors.primaryDark
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
