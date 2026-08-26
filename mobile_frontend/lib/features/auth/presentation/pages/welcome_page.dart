import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/pages/login_page.dart';
import 'package:big_cart/features/auth/presentation/pages/sign_up_page.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  //stateless because there's no input to validate
  @override
  Widget build(BuildContext context) {
    void onClick(int? index) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: ((context) => SignUpPage())));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: WidgetStateColor.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 270.h,
                  top: 0,
                  child: Image.asset(
                    'assets/woman_cart.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  height: 320.h,
                  bottom: 0.h,
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 3.h,
                      children: [
                        Text(
                          'Welcome',
                          style: Fonts.titleBold(
                            size: 25.sp,
                          ).copyWith(color: AppColors.textPrimary),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
                          style: Fonts.paragraphRegular().copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(1.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: TextButton.icon(
                            icon: SvgPicture.asset(
                              'assets/google_logo.svg',
                              width: 20.w,
                              height: 20.h,
                            ),
                            onPressed: () {},
                            label: Text(
                              ' Continue with Google',
                              style: Fonts.titleBold(size: 20).copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        GreenGradientButton.icon(
                          onClick,
                          'Create an account',
                          icon: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((ctx) => LoginPage()),
                                ),
                              );
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have an account? ',
                                style: Fonts.label().copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: Fonts.label().copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.black12],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
