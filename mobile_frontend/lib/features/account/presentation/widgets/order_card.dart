import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/presentation/pages/track_order_page.dart';
import 'package:big_cart/features/account/presentation/widgets/order_progress_indicator.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  final bool hasButton;
  const OrderCard(this.order, {super.key}) : hasButton = true;
  const OrderCard.noButton(this.order, {super.key}) : hasButton = false;

  @override
  State<StatefulWidget> createState() {
    return _OrderCardState();
  }
}

class _OrderCardState extends State<OrderCard> {
  final formKey = GlobalKey();
  bool isClosed = true;
  int numberOfItems = 0;
  double total = 0;
  @override
  void initState() {
    for (CartItem item in widget.order.orderItem) {
      numberOfItems += item.quantity;
      total +=
          (item.product.price * (100 - item.product.discount) / 100) *
          item.quantity;
      //print('${item.product.name} has ${item.quantity}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder: (context) => TrackOrderPage(
              widget.order,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        color: AppColors.backgroundPrimary,
        child: Column(
          spacing: 7.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              spacing: 10.w,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 40.r,
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 3.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${widget.order.id.toString()}',
                        style: Fonts.titleBold(),
                      ),
                      Text(
                        'Placed on ${DateFormat('MMM d, y').format(widget.order.datePlaced)}',
                        style: Fonts.paragraphRegular(size: 12),
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Items: ',
                              style: Fonts.label().copyWith(
                                color: AppColors.textPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: numberOfItems.toString(),
                                  style: Fonts.label().copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Total: ',
                              style: Fonts.label().copyWith(
                                color: AppColors.textPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: '\$${total.toStringAsFixed(2)}',
                                  style: Fonts.label().copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (widget.hasButton)
                    ? Transform.rotate(
                        //there is no identical up arrow so I'll just make my own
                        angle: (!isClosed) ? 3.14159 : 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isClosed = !isClosed;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: AppColors.primaryDark,
                            size: 30.r,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),

            (!isClosed || widget.order.dateDelivered != null)
                ? Divider(
                    thickness: 1.h,
                  )
                : SizedBox(),
            (!isClosed)
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,

                              spacing: 20.w,
                              children: [
                                OrderProgressIndicator(
                                  isActive: true, //placed cannot be null
                                  isFirst: true,
                                ),
                                Text(
                                  'Order placed',
                                  style: Fonts.titleBold(),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat(
                                'MMM d, y',
                              ).format(widget.order.datePlaced),
                              style: Fonts.paragraphRegular(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 20.w,
                              children: [
                                OrderProgressIndicator(
                                  isActive:
                                      (widget.order.dateConfirmed != null),
                                  isFirst: false,
                                ),
                                Text(
                                  'Order confirmed',
                                  style: Fonts.titleBold(),
                                ),
                              ],
                            ),
                            Text(
                              (widget.order.dateConfirmed != null)
                                  ? DateFormat(
                                      'MMM d, y',
                                    ).format(widget.order.dateConfirmed!)
                                  : 'pending',
                              style: Fonts.paragraphRegular(),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 20.w,
                              children: [
                                OrderProgressIndicator(
                                  isActive: (widget.order.dateShipped != null),
                                  isFirst: false,
                                ),
                                Text(
                                  'Order shipped',
                                  style: Fonts.titleBold(),
                                ),
                              ],
                            ),
                            Text(
                              (widget.order.dateShipped != null)
                                  ? DateFormat(
                                      'MMM d, y',
                                    ).format(widget.order.dateShipped!)
                                  : 'pending',
                              style: Fonts.paragraphRegular(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 20.w,
                              children: [
                                OrderProgressIndicator(
                                  isActive:
                                      (widget.order.dateOutForDelivery != null),
                                  isFirst: false,
                                ),
                                Text(
                                  'Out for delivery',
                                  style: Fonts.titleBold(),
                                ),
                              ],
                            ),
                            Text(
                              (widget.order.dateOutForDelivery != null)
                                  ? DateFormat(
                                      'MMM d, y',
                                    ).format(widget.order.dateOutForDelivery!)
                                  : 'pending',
                              style: Fonts.paragraphRegular(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 20.w,
                              children: [
                                OrderProgressIndicator(
                                  isActive:
                                      (widget.order.dateDelivered != null),
                                  isFirst: false,
                                ),
                                Text(
                                  'Order delivered',
                                  style: Fonts.titleBold(),
                                ),
                              ],
                            ),
                            Text(
                              (widget.order.dateDelivered != null)
                                  ? DateFormat(
                                      'MMM d, y',
                                    ).format(widget.order.dateDelivered!)
                                  : 'pending',
                              style: Fonts.paragraphRegular(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : (isClosed && widget.order.dateDelivered != null)
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 20.w,
                          children: [
                            OrderProgressIndicator(
                              isActive: false,
                              isFirst: true,
                            ),
                            Text(
                              'Order delivered',
                              style: Fonts.titleBold(),
                            ),
                          ],
                        ),
                        Text(
                          (widget.order.dateDelivered != null)
                              ? DateFormat(
                                  'MMM d, y',
                                ).format(widget.order.dateDelivered!)
                              : 'pending',
                          style: Fonts.paragraphRegular(),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
