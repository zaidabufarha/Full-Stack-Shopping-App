import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/auth/presentation/models/splash_data.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  int index;
  SplashScreen(this.index, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          ),
          orElse: () {},
        );
      },
      child: PageView.builder(
        controller: pageController,
        itemCount: splashDataList.length,
        itemBuilder: (context, index) {
          return Scaffold(
            body: SizedBox.expand(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      splashDataList[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(50.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          splashDataList[index].title,
                          style: Fonts.titleBold(size: 30),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        (index == 0)
                            ? Image.asset(
                                'assets/logo.png',
                                width: 150.w,
                              )
                            : SizedBox(
                                height: 1.h,
                              ),
                        Text(
                          splashDataList[index].subtitle,
                          style: Fonts.paragraphRegular(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 450.h,
                        ),
                        SmoothPageIndicator(
                          controller: pageController,
                          count: splashDataList.length,
                          effect: ScaleEffect(
                            scale:
                                1, //no animation intended, just want to reach the inner parameters
                            dotColor: Colors.grey,
                            activeDotColor: Colors.green,
                            dotHeight: 10.r,
                            dotWidth: 10.r,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        GreenGradientButton(
                          () => onClick(index),
                          'Get Started',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onClick(int index) {
    {
      setState(() {
        if (index < 3) {
          pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomePage()),
            (route) => false,
          );
        }
      });
    }
  }
}
