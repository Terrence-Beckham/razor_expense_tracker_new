import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../home/view/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // supportedLocales: [Locale('en'), Locale('ar')],
      home: const HomePage(),
    );
  }
}
