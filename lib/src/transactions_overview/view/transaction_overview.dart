import 'package:ads_repo/ads_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razor_expense_tracker_new/src/ads/ads.dart';
import 'package:settings_repo/settings_repo.dart';
import 'package:transactions_repository/transactions_repository.dart';

import '../../edit_transaction/view/edit_transaction_view.dart';
import '../../widgets/konstants.dart';
import '../bloc/transactions_overview_bloc.dart';

class TransactionsOverviewPage extends StatelessWidget {
  const TransactionsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionsOverviewBloc(
              context.read<TransactionsRepo>(),
              context.read<SettingsRepo>(),
              context.read<AdsRepo>()),
        ),
        BlocProvider(
          create: (context) => AdsBloc(
            adsRepo: context.read<AdsRepo>(),
          ),
        ),
      ],
      child: const TransactionsOverviewView(),
    );
  }
}

class TransactionsOverviewView extends StatelessWidget {
  const TransactionsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            'Razor Expense & Budget Tracker',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<TransactionsOverviewBloc, TransactionsOverviewState>(
          builder: (context, state) {
            switch (state.status) {
              case TransactionsOverviewStatus.initial:
                return const Center(child: Text('Initial View'));
              case TransactionsOverviewStatus.empty:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                        context.tr('emptyTransaction'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.arrow_downward_outlined,
                            size: 75,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          Icon(
                            Icons.arrow_downward_outlined,
                            size: 75,
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              case TransactionsOverviewStatus.success:
                return const ExpenseOverviewSuccessView();
              case TransactionsOverviewStatus.failure:
                return Center(
                  child: Text(
                    context.tr('somethingWentWrong'),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class ExpenseOverviewSuccessView extends StatelessWidget {
  const ExpenseOverviewSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsOverviewBloc, TransactionsOverviewState>(
      listenWhen: (previous, current) =>
      previous.deletedTransaction != current.deletedTransaction &&
          current.deletedTransaction != null ||
          (previous.localSetting?.adCounterNumber !=
              current.localSetting?.adCounterNumber),
      listener: (context, state) {
        if (state.deletedTransaction != null) {
          final deletedTransaction = state.deletedTransaction;
          final messenger = ScaffoldMessenger.of(context);
          messenger.showSnackBar(
            SnackBar(
              content: Text(
                context.tr('transactionDeleted'),
                style: GoogleFonts.comicNeue(
                    textStyle: const TextStyle(fontSize: 24),
                    fontWeight: FontWeight.bold),
              ),
              action: SnackBarAction(
                label: context.tr('undo'),
                onPressed: () {
                  // Use the correct context to access the provider
                  context.read<TransactionsOverviewBloc>().add(
                    UndoDeleteTransactionEvent(deletedTransaction!),
                  );
                },
              ),
            ),
          );
        }
        if (state.localSetting!.adCounterNumber >=
            state.localSetting!.adCounterThreshold) {
          context.read<TransactionsOverviewBloc>().add(
            RequestInterstitialEvent(
              onAdDismissedFullScreenContent: () => {},
            ),
          );
        }
      },
      builder: (context, state) {
        final locale = context.locale;

        return LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        context.tr('helloUser'),
                        style: TextStyle(fontSize: isMobile ? 16 : 18),
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(8, 8),
                                blurRadius: 15,
                                spreadRadius: 1),
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(-8, -8),
                                blurRadius: 15,
                                spreadRadius: 1)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[50],
                          child: Icon(
                            Iconsax.user_square,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(8, 8),
                              blurRadius: 15,
                              spreadRadius: 1),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-8, -8),
                              blurRadius: 15,
                              spreadRadius: 1),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              context.tr('totalBalance'),
                              style: TextStyle(
                                fontSize: isMobile ? 20 : 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (state.transactions.isNotEmpty)
                              Text(
                                locale.languageCode == 'en'
                                    ? r'$ ' +
                                    translateDigits(
                                        state.balance.toString(), locale) +
                                    ' '
                                    : translateDigits(
                                    state.balance.toString(), locale) +
                                    ' ' +
                                    r'£',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: isMobile ? 28 : 34,
                                ),
                              )
                            else
                              const Text(r'$'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildInfoColumn(
                                  context,
                                  icon: Iconsax.arrow_up_3,
                                  label: context.tr('income'),
                                  amount: state.incomeTotals.toDouble(),
                                  color: Colors.green,
                                  isMobile: isMobile,
                                ),
                                _buildInfoColumn(
                                  context,
                                  icon: Iconsax.arrow_down,
                                  label: context.tr('expenses'),
                                  amount: state.expenseTotals.toDouble(),
                                  color: Colors.red,
                                  isMobile: isMobile,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.tr('transactions'),
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTransactionsList(state, locale, context, isMobile),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoColumn(BuildContext context,
      {required IconData icon,
        required String label,
        required double amount,
        required Color color,
        required bool isMobile}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1)
            ],
          ),
          child: Icon(
            icon,
            color: color,
            size: isMobile ? 20 : 24,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              r'$ ' + amount.toString(),
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: isMobile ? 20 : 24,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionsList(TransactionsOverviewState state, Locale locale,
      BuildContext context, bool isMobile) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: state.transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(8, 8),
                      blurRadius: 15,
                      spreadRadius: 1),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-8, -8),
                      blurRadius: 15,
                      spreadRadius: 1)
                ],
              ),
              height: isMobile ? 60 : 75,
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        context.read<TransactionsOverviewBloc>().add(
                            DeleteTransactionEvent(
                                state.transactions[index]));
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        context
                            .read<TransactionsOverviewBloc>()
                            .add(IncrementAdCounterEvent());
                        Navigator.of(context).push(
                          MaterialPageRoute<EditTransactionPage>(
                            builder: (context) => EditTransactionPage(
                              transaction: state.transactions[index],
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.green,
                      icon: Icons.edit,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[50],
                    child: Icon(
                      myIcons[state.transactions[index].category?.iconName],
                      color: colorMapper[state.transactions[index]
                          .category?.colorName],
                    ),
                  ),
                  title: Text(
                    context.tr('${state.transactions[index].category?.name?.toLowerCase()}') ??
                        ' ',
                    style: TextStyle(
                        fontSize: isMobile ? 17 : 19,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    state.transactions[index].dateOfTransaction
                        .toString()
                        .substring(0, 10),
                  ),
                  trailing: Text(
                    locale.languageCode == 'en'
                        ? r'$ ' +
                        state.transactions[index].amount.toString()
                        : state.transactions[index].amount.toString() +
                        ' ' +
                        r'£',
                    style: state.transactions[index].isExpense
                        ? const TextStyle(
                      fontSize: 19,
                      color: Colors.red,
                    )
                        : const TextStyle(
                      fontSize: 19,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


String translateDigits(String input, Locale locale) {
  const englishDigits = '0123456789';
  const arabicDigits = '٠١٢٣٤٥٦٧٨٩';

  if (locale.languageCode == 'ar') {
    return input.split('').map((char) {
      if (englishDigits.contains(char)) {
        return arabicDigits[englishDigits.indexOf(char)];
      }
      return char;
    }).join();
  }
  return input;
}
