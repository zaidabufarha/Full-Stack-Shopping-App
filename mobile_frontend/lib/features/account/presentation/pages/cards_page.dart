import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart';
import 'package:big_cart/features/account/presentation/pages/add_credit_card_page.dart';
import 'package:big_cart/features/account/presentation/widgets/credit_card_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _CardsPageState();
  }
}

class _CardsPageState extends State<CardsPage> {
  List<CreditCard> list = [];
  List<CreditCard> originalList = [];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<CardsCubit>().attemptGetCreditCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onClick() {
      final isValid = formKey.currentState?.validate() ?? true;
      if (isValid) {
        final modifiedCards = <CreditCard>[];
        for (int i = 0; i < list.length; i++) {
          final current = list[i];
          final original = i < originalList.length ? originalList[i] : null;
          if (original == null || current != original) {
            modifiedCards.add(current);
          }
        }

        if (modifiedCards.isNotEmpty) {
          context.read<CardsCubit>().attemptUpdateCreditCards(modifiedCards);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddCreditCardPage()),
              );
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
        centerTitle: true,
        title: Text(
          'My Cards',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<CardsCubit, CardsState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (cards) {
                list = cards.map((c) => c.copyWith()).toList();
                originalList = cards.map((c) => c.copyWith()).toList();
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
                context.read<CardsCubit>().attemptGetCreditCards();
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (message) => Column(
                children: [
                  Text(message, style: Fonts.titleBold()),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CardsCubit>().attemptGetCreditCards();
                    },
                    label: Text(
                      'Retry',
                      style: Fonts.paragraphMedium(),
                    ),
                    icon: const Icon(Icons.restart_alt),
                  ),
                ],
              ),
              orElse: () {
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'No cards found',
                      style: Fonts.titleBold(),
                    ),
                  );
                }
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 10.h,
                            children: [
                              for (int i = 0; i < list.length; i++)
                                CreditCardCard(
                                  key: ValueKey(list[i].id ?? '$i'),
                                  list[i],
                                  (updatedCard) {
                                    setState(() {
                                      if (updatedCard.isDefault) {
                                        list = [
                                          for (int j = 0; j < list.length; j++)
                                            if (j == i)
                                              updatedCard
                                            else
                                              list[j].copyWith(isDefault: false),
                                        ];
                                      } else {
                                        list = [
                                          for (int j = 0; j < list.length; j++)
                                            if (j == i)
                                              updatedCard
                                            else
                                              list[j],
                                        ];
                                      }
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      GreenGradientButton(onClick, 'Save settings'),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
