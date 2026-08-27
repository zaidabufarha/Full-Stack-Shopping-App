import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/filters.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/filter_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  Category? category;
  String? searchTerm;
  CategoryPage(this.category, {super.key});
  CategoryPage.search(this.searchTerm, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  Filters? filterData;

  @override
  void initState() {
    context.read<ShopCubit>().attemptGetProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<Filters>(
                MaterialPageRoute(builder: ((context) => const FilterPage())),
              );
              if (result != null) {
                setState(() {
                  filterData = result;
                });
              }
            },
            icon: Icon(
              Icons.tune,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          (widget.category != null)
              ? widget.category!.name
              : widget.searchTerm!,
        ),
        backgroundColor: AppColors.backgroundPrimary,
      ),
      backgroundColor: AppColors.backgroundSecondary,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<ShopCubit, ShopState>(
          builder: (context, state) {
            return state.maybeWhen(
              loadedProducts: (products) {
                List<Product> filteredList = [];
                if (widget.category != null) {
                  filteredList = products
                      .where(
                        (product) =>
                            (product.category.name == widget.category!.name),
                      )
                      .toList();
                } else {
                  filteredList = products
                      .where(
                        (product) => (product.name.toLowerCase().contains(
                          widget.searchTerm!.toLowerCase(),
                        )),
                      )
                      .toList();
                }

                if (filterData != null) {
                  filteredList = filteredList.where((product) {
                    if (filterData!.minPrice != null &&
                        product.price < filterData!.minPrice!) {
                      return false;
                    }
                    if (filterData!.maxPrice != null &&
                        product.price > filterData!.maxPrice!) {
                      return false;
                    }
                    if (filterData!.discountOnly && product.discount <= 0) {
                      return false;
                    }
                    if (filterData!.freeShippingOnly && !product.freeShipping) {
                      return false;
                    }
                    if (filterData!.sameDayDeliveryOnly &&
                        !product.sameDayDelivery) {
                      return false;
                    }
                    if (filterData!.minRating > 0) {
                      double sumOfRatings = 0;
                      for (int i = 0; i < product.review.length; i++) {
                        sumOfRatings += product.review[i].rating;
                      }
                      double avgRating = 0;
                      if (product.review.isNotEmpty) {
                        avgRating = sumOfRatings / product.review.length;
                      }
                      if (avgRating < filterData!.minRating) {
                        return false;
                      }
                    }
                    return true;
                  }).toList();
                }

                return filteredList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No products found',
                            style: Fonts.titleBold(size: 30),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: ProductList(filteredList),
                      );
              },
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
              error: (message) => Center(
                child: Column(
                  children: [
                    Text(message, style: Fonts.titleBold()),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ShopCubit>().attemptGetProductList();
                      },
                      label: Text('Retry'),
                      icon: Icon(Icons.restart_alt),
                    ),
                  ],
                ),
              ),
              orElse: () => Center(
                child: Column(
                  children: [
                    Text('Something went wrong', style: Fonts.titleBold()),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ShopCubit>().attemptGetProductList();
                      },
                      label: Text('Retry'),
                      icon: Icon(Icons.restart_alt),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
