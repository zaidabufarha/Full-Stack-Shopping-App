import 'dart:io';

import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/user_cubit.dart';
import 'package:big_cart/features/account/presentation/pages/about_page.dart';
import 'package:big_cart/features/account/presentation/pages/address_page.dart';
import 'package:big_cart/features/account/presentation/pages/cards_page.dart';
import 'package:big_cart/features/account/presentation/pages/notifications_page.dart';
import 'package:big_cart/features/account/presentation/pages/order_page.dart';
import 'package:big_cart/features/account/presentation/pages/transactions_page.dart';
import 'package:big_cart/features/account/presentation/widgets/profile_page_option.dart';
import 'package:big_cart/features/auth/presentation/pages/splash_screen.dart';
import 'package:big_cart/features/buy/presentation/pages/cart_page.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<UserCubit>().attemptGetUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: Fonts.paragraphMedium().copyWith(color: Colors.white),
                ),
                backgroundColor: AppColors.primaryDark,
              ),
            );
            context.read<UserCubit>().attemptGetUserData();
          },

          error: (message) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: Fonts.paragraphMedium().copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Scaffold(
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,

            bottomNavigationBar: NavigationBar(
              selectedIndex: 1,
              onDestinationSelected: (index) {
                if (index == 0) {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: ((context) => HomePage())));
                } else if (index == 2) {
                  Navigator.of(
                    context,
                  ).push(
                    MaterialPageRoute(
                      builder: ((context) =>
                          CartPage.favorites()), //i should make this work when i do buy
                    ),
                  );
                }
              },
              height: 60.h,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: AppColors.textSecondary,
                    size: 30.r,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline,
                    color: AppColors.textPrimary,

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
            backgroundColor: AppColors.backgroundPrimary,
            body: Stack(
              children: [
                Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  top: 200.h,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    color: AppColors.backgroundSecondary,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          error: (message) => Scaffold(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => CartPage()),
                    ), //handle later
                  );
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,

            bottomNavigationBar: NavigationBar(
              height: 60.h,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: AppColors.textSecondary,
                    size: 30.r,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline,
                    color: AppColors.textPrimary,

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
            backgroundColor: AppColors.backgroundPrimary,
            body: Stack(
              children: [
                Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  top: 200.h,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    color: AppColors.backgroundSecondary,
                    child: Column(
                      children: [
                        Text(
                          message,
                          style: Fonts.titleBold(),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<UserCubit>().attemptGetUserData();
                          },
                          label: Text(
                            'Retry',
                            style: Fonts.paragraphMedium(),
                          ),
                          icon: Icon(Icons.restart_alt),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          loadedUser: (user) => Scaffold(
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,

            bottomNavigationBar: NavigationBar(
              selectedIndex: 1,
              onDestinationSelected: (index) {
                if (index == 0) {
                  Navigator.of(
                    context,
                  ).push(
                    MaterialPageRoute(builder: ((context) => HomePage())),
                  );
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

            backgroundColor: AppColors.backgroundPrimary,
            body: Stack(
              children: [
                Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  top: 200.h,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    color: AppColors.backgroundSecondary,
                    child: Column(
                      spacing: 15.h,
                      children: [
                        SizedBox(
                          height: 80.h,
                        ),
                        ProfilePageOption(
                          icon: Icons.person_outline,
                          text: 'About me',
                          destination: AboutPage(user),
                        ),
                        ProfilePageOption(
                          icon: Icons.inventory_2_outlined,
                          text: 'My Orders',
                          destination: OrderPage(),
                        ),
                        ProfilePageOption(
                          icon: Icons.favorite_outline,
                          text: 'My Favorites',
                          destination: CartPage.favorites(),
                        ),
                        ProfilePageOption(
                          icon: Icons.location_on_outlined,
                          text: 'My Address',
                          destination: AddressPage(),
                        ),
                        ProfilePageOption(
                          icon: Icons.credit_card_outlined,
                          text: 'Credit Cards',
                          destination: CardsPage(),
                        ),
                        ProfilePageOption(
                          icon: Icons.attach_money,
                          text: 'Transactions',
                          destination: TransactionsPage(),
                        ),
                        ProfilePageOption(
                          icon: Icons.notifications_outlined,
                          text: 'Notifications',
                          destination: NotificationsPage(),
                        ),
                        ProfilePageOption(
                          signOut: true,
                          icon: Icons.logout_rounded,
                          text: 'Sign out',
                          destination: SplashScreen(0),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 120.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 67.r,
                        backgroundImage: appImageProvider(user.imagePath),
                      ),
                      Text(
                        user.name,
                        style: Fonts.titleBold(),
                      ),
                      Text(
                        user.email,
                        style: Fonts.paragraphRegular(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 210.h,
                  left: 230.w,
                  child: Container(
                    width: 30.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryDark,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.only(right: 0.w),
                      onPressed: () async {
                        final imagePicker = ImagePicker();
                        final result = await imagePicker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (result == null) {
                          return;
                        } else {
                          if (!context.mounted) return; // just in case
                          context.read<UserCubit>().attemptAddProfilePicture(
                            result.path,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 19.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
