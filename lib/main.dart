import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:local_storage_transactions_api/local_storage_transactions_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:razor_expense_tracker_new/src/app/app.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer =  AppBlocObserver();
  await EasyLocalization.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [TransactionSchema, StoredCategorySchema],
    directory: dir.path,
  );
  final transactionsApi = LocalStorageTransactionsApi(
    isarDb: isar,
  );

  final transactionRepository = TransactionsRepository(
    transactionsApi: transactionsApi,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: RepositoryProvider(
        create: (context) => transactionRepository,
        child: App(transactionsRepository: transactionRepository),
      ),
    ),
  );
}
// RepositoryProvider(
// create: (context) => transactionRepository,
// ),
