import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/user_cubit.dart';
import 'package:big_cart/features/account/presentation/widgets/green_switch_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationsPageState();
  }
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool allowNotifications = true;
  bool allowEmailNotifications = true;
  bool allowOrderNotifications = true;
  bool allowGeneralNotifications = true;
  bool loaded = false;

  @override
  void initState() {
    context.read<UserCubit>().attemptGetNotificationPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onClick() {
      if (loaded) {
        context.read<UserCubit>().attemptSetNotificationPreferences(
          allowNotifications: allowNotifications,
          allowEmailNotifications: allowEmailNotifications,
          allowOrderNotifications: allowOrderNotifications,
          allowGeneralNotifications: allowGeneralNotifications,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),

        centerTitle: true,
        title: Text(
          'Notifications',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: SingleChildScrollView(
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loadedPreferences: (preferences) {
                      allowEmailNotifications = preferences.allowEmail;
                      allowGeneralNotifications = preferences.allowGeneral;
                      allowOrderNotifications = preferences.allowOrder;
                      loaded = true;
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
                    },

                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) => Center(
                      child: Column(
                        children: [
                          Text(message, style: Fonts.titleBold()),
                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<UserCubit>()
                                  .attemptGetNotificationPreferences();
                            },
                            label: Text('Retry'),
                            icon: Icon(Icons.restart_alt),
                          ),
                        ],
                      ),
                    ),
                    orElse: () => Column(
                      spacing: 10.h,
                      children: [
                        GreenSwitchListTile(
                          isActive: allowNotifications,
                          title: 'Allow Notifications',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumym',
                          onChanged: (allow) {
                            if (!allow) {
                              setState(() {
                                allowNotifications = false;
                                allowEmailNotifications = false;
                                allowGeneralNotifications = false;
                                allowOrderNotifications = false;
                              });
                            } else {
                              setState(() {
                                allowNotifications = true;
                              });
                              context
                                  .read<UserCubit>()
                                  .getNotificationPreferences();
                            }
                          },
                        ),
                        GreenSwitchListTile(
                          isActive: allowEmailNotifications,
                          title: 'Email Notifications',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumym',
                          onChanged: (allow) {
                            setState(() {
                              allowEmailNotifications = allow;
                            });
                          },
                        ),
                        GreenSwitchListTile(
                          isActive: allowOrderNotifications,
                          title: 'Order Notifications',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumym',
                          onChanged: (allow) {
                            setState(() {
                              allowOrderNotifications = allow;
                            });
                          },
                        ),
                        GreenSwitchListTile(
                          isActive: allowGeneralNotifications,
                          title: 'General Notifications',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumym',
                          onChanged: (allow) {
                            setState(() {
                              allowGeneralNotifications = allow;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GreenGradientButton(onClick, 'Save settings'),
          ),
        ],
      ),
    );
  }
}
