import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:big_cart/features/buy/presentation/pages/shipping_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CartPage extends StatefulWidget {
  bool favorites = false;
  double subtotal = 0;
  double shipping = 1.5;
  CartPage({super.key});
  CartPage.favorites({super.key}) : favorites = true;

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  List<CartItem> checkOutList = []; // cant pass to onclick

  @override
  void initState() {
    context.read<CartCubit>().attemptGetCartItems(
      isFavorites: widget.favorites,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onClick(int? index) {
      if (checkOutList.isNotEmpty) {
        //context.read<CartCubit>().attemptCheckOut(checkOutList);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ShippingPage(checkOutList)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => HomePage())),
        );
      }
    }

    double sumOfPrices(List<CartItem> items) {
      double sum = 0;
      for (CartItem item in items) {
        sum +=
            item.product.price *
            item.quantity *
            (100 - item.product.discount) /
            100;
      }
      return sum;
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
          (widget.favorites) ? 'Favorites' : 'Shopping Cart',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: BlocListener<ShopCubit, ShopState>(
        //for the favorites page
        listener: (context, state) {
          state.whenOrNull(
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
              if (widget.favorites) {
                context.read<CartCubit>().attemptGetCartItems(
                  isFavorites: true,
                );
              }
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
          );
        },

        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (products) {
                checkOutList = products;
                //updates after the success of anything because loaded is emitted again. always up to date.
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
                context.read<CartCubit>().attemptGetCartItems(
                  isFavorites: widget.favorites,
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (products) => (products.isNotEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(20),
                            child: SingleChildScrollView(
                              child: Column(
                                spacing: 10.h,
                                children: [
                                  for (CartItem item in products)
                                    CartCard(
                                      item,
                                      isFavorites: widget.favorites,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        (widget.favorites)
                            ? SizedBox()
                            : Container(
                                padding: const EdgeInsets.all(20),
                                color: AppColors.backgroundPrimary,
                                child: Column(
                                  spacing: 10.h,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Subtotal',
                                          style: Fonts.paragraphMedium(),
                                        ),
                                        Text(
                                          '\$${sumOfPrices(products)}',
                                          style: Fonts.paragraphMedium(),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Shipping charges',
                                          style: Fonts.paragraphMedium(),
                                        ),
                                        Text(
                                          '\$${widget.shipping}',
                                          style: Fonts.paragraphMedium(),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: Fonts.titleBold(size: 18),
                                        ),
                                        Text(
                                          '\$${sumOfPrices(products) + widget.shipping}',
                                          style: Fonts.titleBold(size: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(),
                                    GreenGradientButton(onClick, 'Checkout'),
                                  ],
                                ),
                              ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(80),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    (widget.favorites)
                                        ? Icons.favorite_outline
                                        : Icons.shopping_bag_outlined,
                                    color: (widget.favorites)
                                        ? Colors.red
                                        : AppColors.primaryDark,
                                    size: 200.r,
                                  ),
                                  Text(
                                    (widget.favorites)
                                        ? 'No favorites added'
                                        : 'Your cart is empty!',
                                    textAlign: TextAlign.center,
                                    style: Fonts.titleBold(size: 30),
                                  ),
                                  Text(
                                    (widget.favorites)
                                        ? 'Add items to your favorites by pressing the heart icon.'
                                        : 'Add items to your cart to see them here.',
                                    textAlign: TextAlign.center,
                                    style: Fonts.paragraphRegular(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: GreenGradientButton(
                            onClick,
                            'Start shopping',
                          ),
                        ),
                      ],
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
