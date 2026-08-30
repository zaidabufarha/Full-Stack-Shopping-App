import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AboutPage extends StatefulWidget {
  User user;
  AboutPage(this.user, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  late String name;
  late String email;
  late String phoneNumber;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onClick() {
      bool isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        context.read<UserCubit>().attemptUpdateProfile(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          currentPassword: currentPasswordController.text,
          newPassword1: newPasswordController.text,
          newPassword2: confirmPasswordController.text,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),

        centerTitle: true,
        title: Text(
          'About me',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: BlocListener<UserCubit, UserState>(
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
                    style: Fonts.paragraphMedium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: AppColors.primaryDark,
                ),
              );
              Navigator.of(context).pop();
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
                    style: Fonts.paragraphMedium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.h,
                      children: [
                        Text(
                          'Personal Details',
                          style: Fonts.titleBold(size: 20),
                        ),
                        TextFormField(
                          initialValue: widget.user.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Russel Austin',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (newName) {
                            if (newName == null || newName.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newName) {
                            name = newName!;
                          },
                        ),
                        TextFormField(
                          initialValue: widget.user.email,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'russel.partner@gmail.com',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (newEmail) {
                            if (newEmail == null || newEmail.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newEmail) {
                            email = newEmail!;
                          },
                        ),
                        TextFormField(
                          initialValue: widget.user.phone,

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.phone_outlined,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              '+1 202 555 0142',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (newNumber) {
                            if (newNumber == null || newNumber.isEmpty) {
                              return 'Cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (newNumber) {
                            phoneNumber = newNumber!;
                          },
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          'Change Password',
                          style: Fonts.titleBold(size: 20),
                        ),
                        TextFormField(
                          controller: currentPasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Current password',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          validator: (val) {
                            final isChanging =
                                currentPasswordController.text.isNotEmpty ||
                                newPasswordController.text.isNotEmpty ||
                                confirmPasswordController.text.isNotEmpty;
                            if (isChanging && (val == null || val.isEmpty)) {
                              return 'Current password required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            ),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: (hidePassword)
                                  ? Icon(Icons.visibility_outlined)
                                  : Icon(Icons.visibility_off_outlined),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              '● ● ● ● ●',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          obscureText: hidePassword,
                          validator: (val) {
                            final isChanging =
                                currentPasswordController.text.isNotEmpty ||
                                newPasswordController.text.isNotEmpty ||
                                confirmPasswordController.text.isNotEmpty;
                            if (isChanging) {
                              if (val == null || val.isEmpty) {
                                return 'New password required';
                              }
                              if (val.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundPrimary,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hint: Text(
                              'Confirm password',
                              style: Fonts.paragraphRegular(),
                            ),
                          ),
                          obscureText: hidePassword,
                          validator: (val) {
                            final isChanging =
                                currentPasswordController.text.isNotEmpty ||
                                newPasswordController.text.isNotEmpty ||
                                confirmPasswordController.text.isNotEmpty;
                            if (isChanging) {
                              if (val == null || val.isEmpty) {
                                return 'Confirm password required';
                              }
                              if (val != newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: GreenGradientButton(onClick, 'Save settings'),
            ),
          ],
        ),
      ),
    );
  }
}
