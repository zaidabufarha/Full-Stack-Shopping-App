import 'package:big_cart/features/account/presentation/pages/profile_page.dart';
import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/cart_page.dart';
import 'package:big_cart/features/buy/presentation/pages/category_list_page.dart';
import 'package:big_cart/features/buy/presentation/pages/category_page.dart';
import 'package:big_cart/features/buy/presentation/pages/search_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/category_icon.dart';
import 'package:big_cart/features/buy/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //this page needs to load two lists. i'll use local lists to handle this.
  List<Category> categoryList = [];
  List<Product> productList = [];

  @override
  void initState() {
    context.read<ShopCubit>().attemptGetCategoryList();
    context.read<ShopCubit>().attemptGetProductList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 85.w,
        height: 85.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryDark,
          border: Border.all(width: 10.w, color: Colors.white),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => CartPage()));
          },
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: ((context) => ProfilePage())));
          } else if (index == 2) {
            Navigator.of(
              context,
            ).push(
              MaterialPageRoute(
                builder: ((context) => CartPage.favorites()),
              ),
            );
          }
        },
        height: 50.h,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: 30.r,
              color: AppColors.textPrimary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              color: AppColors.textSecondary,
              size: 30.r,
            ),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.favorite_outline,
              color: AppColors.textSecondary,
              size: 30.r,
            ),
            label: 'Favorites',
          ),
          SizedBox(),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 20.h,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.backgroundPrimary, //white
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<CartCubit, CartState>(
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
          child: BlocConsumer<ShopCubit, ShopState>(
            listener: (context, state) {
              state.whenOrNull(
                loadedCategories: (categories) {
                  setState(() {
                    categoryList = categories;
                  });
                },
                loadedProducts: (products) {
                  setState(() {
                    productList = products;
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
            builder: (context, state) {
              return state.maybeWhen(
                error: (message) => Center(
                  child: Column(
                    children: [
                      Text(message, style: Fonts.titleBold()),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<ShopCubit>().attemptGetCategoryList();
                          context.read<ShopCubit>().attemptGetProductList();
                        },
                        label: Text('Retry'),
                        icon: Icon(Icons.restart_alt),
                      ),
                    ],
                  ),
                ),
                loading: () => Center(child: CircularProgressIndicator()),
                orElse: () => SingleChildScrollView(
                  child: Column(
                    spacing: 10.h,
                    children: [
                      TextField(
                        readOnly:
                            true, // i dont really need the text functionality here because theres a seperate search page
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SearchPage(),
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          fillColor: AppColors.backgroundSecondary,
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          suffixIcon: Icon(
                            Icons.tune,
                            color: AppColors.textSecondary,
                          ),
                          hint: Text(
                            'Search keywords..',
                            style: Fonts.paragraphRegular(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 280.h,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/discount.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              width: 200.w,
                              top: 160.h,
                              left: 60.w,
                              child: Text(
                                '20% off on your first purchase',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: Fonts.titleBold(size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryListPage(categoryList),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: Fonts.titleBold(size: 20),
                            ),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          itemBuilder: ((context, index) =>
                              CategoryIcon(categoryList[index])),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryPage.search(''), // all products
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured products',
                              style: Fonts.titleBold(size: 20),
                            ),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                      ProductList(productList),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
