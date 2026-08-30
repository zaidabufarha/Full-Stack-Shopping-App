import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/buy/domain/entities/filters.dart';
import 'package:big_cart/features/buy/presentation/widgets/filter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FilterPageState();
  }
}

class _FilterPageState extends State<FilterPage> {
  final _formKey = GlobalKey<FormState>();
  double minRating = 0;
  double? minPrice;
  double? maxPrice;
  bool discountOnly = false;
  bool freeShippingOnly = false;
  bool sameDayDeliveryOnly = false;

  void onClick() {
    _formKey.currentState?.save();
    Navigator.of(context).pop(
      Filters(
        minRating: minRating,
        minPrice: minPrice,
        maxPrice: maxPrice,
        discountOnly: discountOnly,
        freeShippingOnly: freeShippingOnly,
        sameDayDeliveryOnly: sameDayDeliveryOnly,
      ),
    );
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
              setState(() {
                minRating = 0;
                minPrice = null;
                maxPrice = null;
                discountOnly = false;
                freeShippingOnly = false;
                sameDayDeliveryOnly = false;
                _formKey.currentState?.reset();
              });
            },
            icon: Icon(Icons.restart_alt_outlined),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Apply Filters',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: AppColors.backgroundPrimary,
                padding: EdgeInsets.all(10),
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price range',
                      style: Fonts.titleBold(),
                    ),
                    Row(
                      spacing: 10.w,
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (val) {
                              minPrice = (val != null && val.isNotEmpty)
                                  ? double.tryParse(val)
                                  : null;
                            },
                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundSecondary,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hint: Text(
                                'Min.',
                                style: Fonts.paragraphRegular(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (val) {
                              maxPrice = (val != null && val.isNotEmpty)
                                  ? double.tryParse(val)
                                  : null;
                            },
                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundSecondary,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hint: Text(
                                'Max.',
                                style: Fonts.paragraphRegular(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      'Star rating',
                      style: Fonts.titleBold(),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: AppColors.backgroundSecondary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemSize: 25,
                            initialRating: minRating,
                            allowHalfRating: true,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (newRating) {
                              setState(() {
                                minRating = newRating;
                              });
                            },
                          ),
                          Text(
                            '$minRating stars',
                            style: Fonts.paragraphRegular(),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Text(
                      'Others',
                      style: Fonts.titleBold(),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          discountOnly = !discountOnly;
                        });
                      },
                      child: FilterCard(
                        label: 'Discount',
                        isActive: discountOnly,
                        icon: Icons.sell_outlined,
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          freeShippingOnly = !freeShippingOnly;
                        });
                      },
                      child: FilterCard(
                        label: 'Free shipping',
                        isActive: freeShippingOnly,
                        icon: Icons.local_shipping_outlined,
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          sameDayDeliveryOnly = !sameDayDeliveryOnly;
                        });
                      },
                      child: FilterCard(
                        label: 'Same day delivery',
                        isActive: sameDayDeliveryOnly,
                        icon: Icons.inventory_2_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              GreenGradientButton(onClick, 'Apply filter'),
            ],
          ),
        ),
      ),
    );
  }
}
