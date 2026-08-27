import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/auth/presentation/pages/login_page.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/auth/presentation/pages/verify_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  bool obscure = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late String inputEmail;
    late String inputPhoneNumber;
    late String inputPassword;

    //this function doesnt use int but it's still a bit cleaner than reusing button code
    void onClick(int? index) {
      bool isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        context.read<AuthCubit>().attemptSignUp(
          inputEmail,
          inputPassword,
          inputPhoneNumber,
        );
      }
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: ((context) => VerifyNumberPage(
                  inputEmail: inputEmail,
                  inputPhoneNumber: inputPhoneNumber,
                  inputPassword: inputPassword,
                )),
              ),
              (route) => false,
            );
          },
          error: (errorMessage) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorMessage)));
          },

          orElse: () {},
        );
      },
      child: Scaffold(
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
                    bottom: 370.h,
                    top: 0,
                    child: Image.asset(
                      'assets/woman_happy.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    height: 420.h,
                    bottom: 0.h,
                    child: Container(
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 3.h,
                          children: [
                            Text(
                              'Create account',
                              style: Fonts.titleBold(
                                size: 25.sp,
                              ).copyWith(color: AppColors.textPrimary),
                            ),
                            Text(
                              'Quickly create account',
                              style: Fonts.paragraphRegular().copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.mail_outline),
                                hint: Text(
                                  'Email Address',
                                  style: Fonts.paragraphRegular().copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                inputEmail = newValue!;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.phone_outlined),
                                hint: Text(
                                  'Phone number',
                                  style: Fonts.paragraphRegular().copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                inputPhoneNumber = newValue!;
                              },
                            ),
                            TextFormField(
                              obscureText: obscure,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  icon: Icon(
                                    (obscure)
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                hint: Text(
                                  'Password',
                                  style: Fonts.paragraphRegular().copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cannot be empty';
                                }
                                if (value.length < 8) {
                                  return 'Must be at least 8 characters';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                inputPassword = newValue!;
                              },
                            ),
                            GreenGradientButton(
                              onClick,
                              'Signup',
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: ((context) => LoginPage()),
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
      ),
    );
  }
}
