import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/auth/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ProfilePageOption extends StatelessWidget {
  IconData icon;
  String text;
  Widget destination;
  bool signOut;
  ProfilePageOption({
    super.key,
    required this.icon,
    required this.text,
    required this.destination,
    this.signOut = false,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primaryDark,
      onTap: () async {
        if (signOut) {
          await context.read<AuthCubit>().attemptSignOut();
          print('signed out');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen(0)),
            (route) => false,
          );
        }
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: ((context) => destination)));
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 20.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppColors.primaryDark,
                size: 30.r,
              ),
              Text(
                text,
                style: Fonts.titleBold(size: 20),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: 30.r,
          ),
        ],
      ),
    );
  }
}
