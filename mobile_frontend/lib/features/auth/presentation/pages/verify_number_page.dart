import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

class VerifyNumberPage extends StatefulWidget {
  String inputEmail;
  String inputPhoneNumber;
  String inputPassword;
  VerifyNumberPage({
    required this.inputEmail,
    required this.inputPassword,
    required this.inputPhoneNumber,
    super.key,
  });
  @override
  State<StatefulWidget> createState() {
    return _VerifyNumberPageState();
  }
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  bool otpSent = false;
  bool otpComplete = false;
  bool numberValid = false;
  PhoneNumber? inputNumber;
  String? inputOtp;
  @override
  Widget build(BuildContext context) {
    //this function doesnt use int but it's still a bit cleaner than reusing button code
    void onClick(int? index) {
      if (numberValid && !otpSent) {
        context.read<AuthCubit>().sendOtpToUser(inputNumber!.toString());
        setState(() {
          otpSent = true;
          print('Valid number entered: $inputNumber');
        });
      } else if (numberValid && otpComplete) {
        context.read<AuthCubit>().verifyUserOtp(
          email: widget.inputEmail,
          otp: inputOtp!,
          password: widget.inputPassword,
          number: widget.inputPhoneNumber,
        );
      }
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: ((context) => HomePage())),
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
        backgroundColor: AppColors.backgroundSecondary,
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
            'Verify Number',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              spacing: 20.h,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verify your number',
                  style: Fonts.titleBold(size: 25),
                ),
                Text(
                  (otpSent)
                      ? 'Enter your OTP code below'
                      : 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
                  style: Fonts.paragraphRegular(),
                  textAlign: TextAlign.center,
                ),
                (otpSent)
                    ? Pinput(
                        length: 6,
                        obscureText: true,
                        defaultPinTheme: PinTheme(
                          width: 60.w,
                          height: 60.h,
                          textStyle: Fonts.titleBold(size: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          inputOtp = value;
                        },
                        onCompleted: (inputOtp) {
                          print(inputOtp);
                          otpComplete = true;
                        },
                      )
                    : InternationalPhoneNumberInput(
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        onInputChanged: (number) {
                          inputNumber = number;
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        errorMessage: 'Enter a valid phone number',
                        onInputValidated: (bool isValid) {
                          setState(() {
                            numberValid = isValid;
                          });
                        },
                      ),
                (otpSent)
                    ? Text(
                        'Didn\'t receive a code?',
                        style: Fonts.paragraphMedium(),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                (otpSent)
                    ? Text(
                        'Resend a new code',
                        style: Fonts.paragraphMedium().copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                GreenGradientButton(onClick, 'Next'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
