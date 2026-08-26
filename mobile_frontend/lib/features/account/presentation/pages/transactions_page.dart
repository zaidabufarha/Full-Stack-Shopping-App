import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/transactions_cubit.dart';
import 'package:big_cart/features/account/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TransactionsPageState();
  }
}

class _TransactionsPageState extends State<TransactionsPage> {
  late List<Transaction> list;

  @override
  void initState() {
    context.read<TransactionsCubit>().attemptGetTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'Transactions',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: SingleChildScrollView(
          child: BlocConsumer<TransactionsCubit, TransactionsState>(
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
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (transactions) {
                  list = transactions;
                  return Column(
                    spacing: 20.h,
                    children: [
                      for (Transaction transaction in transactions)
                        TransactionCard(transaction),
                    ],
                  );
                },
                orElse: () => Column(
                  children: [
                    Text('Something went wrong'),
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<TransactionsCubit>()
                            .attemptGetTransactions();
                      },
                      label: Text(
                        'Retry',
                        style: Fonts.paragraphMedium(),
                      ),
                      icon: Icon(Icons.restart_alt),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
