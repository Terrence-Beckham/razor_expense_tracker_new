import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razor_expense_tracker_new/main.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

void bootstrap({required TransactionsApi transactionsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final transactionRepository = TransactionsRepository(
    transactionsApi: transactionsApi,
  );

  runZonedGuarded(
    () => runApp(MyApp(transactionsRepository: transactionRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}


class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
