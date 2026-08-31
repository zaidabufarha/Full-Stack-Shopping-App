import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/presentation/widgets/big_order_progress_indicator.dart';
import 'package:big_cart/features/account/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart';

class TrackOrderPage extends StatelessWidget {
  final Order order;
  const TrackOrderPage(this.order, {super.key});

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

        centerTitle: true,
        title: Text(
          'Track Order',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10.h,
            children: [
              OrderCard.noButton(order),
              Container(
                color: AppColors.backgroundPrimary,

                child: Row(
                  spacing: 15.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        BigOrderProgressIndicator(
                          isActive: true,
                          isFirst: true,
                          icon: Icon(Icons.inventory_outlined),
                        ),
                        BigOrderProgressIndicator(
                          isActive: (order.dateConfirmed != null),
                          isFirst: false,
                          icon: Icon(Icons.check_circle_outline),
                        ),
                        BigOrderProgressIndicator(
                          isActive: (order.dateShipped != null),
                          isFirst: false,
                          icon: Icon(Icons.route_outlined),
                        ),
                        BigOrderProgressIndicator(
                          isActive: (order.dateOutForDelivery != null),
                          isFirst: false,
                          icon: Icon(Icons.local_shipping_outlined),
                        ),
                        BigOrderProgressIndicator(
                          isActive: (order.dateDelivered != null),
                          isFirst: false,
                          icon: Icon(Icons.airport_shuttle_outlined),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 18.h,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Order Placed',
                            style: Fonts.titleBold(size: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            DateFormat(
                              'MMM d, y',
                            ).format(order.datePlaced),
                            style: Fonts.paragraphMedium(),
                            textAlign: TextAlign.start,
                          ),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: AppColors.textSecondary.withAlpha(128),
                          ),
                          Text(
                            'Order Confirmed',
                            style: Fonts.titleBold(size: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            order.dateConfirmed != null
                                ? DateFormat(
                                    'MMM d, y',
                                  ).format(order.dateConfirmed!)
                                : 'Pending',
                            style: Fonts.paragraphMedium(),
                            textAlign: TextAlign.start,
                          ),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: AppColors.textSecondary.withAlpha(128),
                          ),
                          Text(
                            'Order Shipped',
                            style: Fonts.titleBold(size: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            order.dateShipped != null
                                ? DateFormat(
                                    'MMM d, y',
                                  ).format(order.dateShipped!)
                                : 'Pending',
                            style: Fonts.paragraphMedium(),
                            textAlign: TextAlign.start,
                          ),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: AppColors.textSecondary.withAlpha(128),
                          ),
                          Text(
                            'Out for Delivery',
                            style: Fonts.titleBold(size: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            order.dateOutForDelivery != null
                                ? DateFormat(
                                    'MMM d, y',
                                  ).format(order.dateOutForDelivery!)
                                : 'Pending',
                            style: Fonts.paragraphMedium(),
                            textAlign: TextAlign.start,
                          ),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: AppColors.textSecondary.withAlpha(128),
                          ),
                          Text(
                            'Order Delivered',
                            style: Fonts.titleBold(size: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            order.dateDelivered != null
                                ? DateFormat(
                                    'MMM d, y',
                                  ).format(order.dateDelivered!)
                                : 'Pending',
                            style: Fonts.paragraphMedium(),
                            textAlign: TextAlign.start,
                          ),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: AppColors.textSecondary.withAlpha(128),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //OrderCard.closed(orderList[1]),
            ],
          ),
        ),
      ),
    );
  }
}
