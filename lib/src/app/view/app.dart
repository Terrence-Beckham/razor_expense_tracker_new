import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razor_expense_tracker_new/src/transactions_overview/view/transaction_overview.dart';
import 'package:transactions_repository/transactions_repository.dart';

import '../../home/view/home_page.dart';

class App extends StatelessWidget {
  const App({
    required TransactionsRepository transactionsRepository,
    super.key,
  }) : _transactionsRepository = transactionsRepository;

  final TransactionsRepository _transactionsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _transactionsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF080C36),
          primary: const Color(0xFF080C36),
          secondary: const Color(0xFFC5CAE9),
          background: Colors.white,
          onError: Colors.red,
          onTertiary: Colors.amber,
        ),
        appBarTheme: AppBarTheme(
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
