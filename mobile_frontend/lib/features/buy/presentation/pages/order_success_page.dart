import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/presentation/pages/track_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class OrderSuccessPage extends StatelessWidget {
  final formKey = GlobalKey();
  Order order;
  OrderSuccessPage(this.order, {super.key});
  @override
  Widget build(BuildContext context) {
    void onClick(int? index) {
      Navigator.of(
        context,
      ).push(
        MaterialPageRoute(builder: (context) => TrackOrderPage(order)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
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
          'Order Success',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Column(
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
                      Icons.shopping_bag_outlined,
                      color: AppColors.primaryDark,
                      size: 200.r,
                    ),
                    Text(
                      'Your order was successful!',
                      textAlign: TextAlign.center,
                      style: Fonts.titleBold(size: 30),
                    ),
                    Text(
                      'You will get a response wihtin a few minutes.',
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
            child: GreenGradientButton(onClick, 'Track order'),
          ),
        ],
      ),
    );
  }
}
