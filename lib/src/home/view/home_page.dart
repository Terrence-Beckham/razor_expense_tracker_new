import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:razor_expense_tracker_new/src/add_transaction/view/add_transaction_view.dart';
import 'package:razor_expense_tracker_new/src/home/cubit/home_cubit.dart';
import 'package:razor_expense_tracker_new/src/stats/view/stats_view.dart';
import 'package:transactions_repository/transactions_repository.dart';
import '../../stats/bloc/stats_bloc.dart';
import '../../transactions_overview/bloc/transactions_overview_bloc.dart';
import '../../transactions_overview/view/transaction_overview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => HomeCubit(),
        child: HomeView(),
      ),
      BlocProvider<TransactionsOverviewBloc>(
        create: (_) =>
            TransactionsOverviewBloc(
              context.read<TransactionsRepository>(),
            ),
      ),
      BlocProvider<StatsBloc>(
        create: (_) => StatsBloc(context.read<TransactionsRepository>()),
      ),
    ], child: HomeView());
  }
}

class HomeView extends StatelessWidget {
  HomeView({
    super.key,
  }) : _logger = Logger();

  final Logger _logger;

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab.index,
          children: const [TransactionsOverviewPage(), StatsOverviewPage()],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          // shape: const CircleBorder(),
          backgroundColor: Colors.grey,

          onPressed: () {
             Navigator.of(context)
                .push(MaterialPageRoute<AddTransactionPage>(
              builder: (context) => const AddTransactionPage(),
            ));
          },
          key: const Key('homeView_addTransaction_floatingActionButton'),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: Container(
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
          child: BottomAppBar(
            color: Colors.grey[50],
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _HomeTabButton(
                  groupValue: selectedTab,
                  value: HomeTab.transactions,
                  icon: const Icon(Icons.home),
                ),
                _HomeTabButton(
                  groupValue: selectedTab,
                  value: HomeTab.stats,
                  icon: const Icon(Icons.show_chart_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color:
      groupValue == value ? null : Theme
          .of(context)
          .colorScheme
          .secondary,
      icon: icon,
    );
  }
}
