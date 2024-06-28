import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_transactions_api/local_storage_transactions_api.dart';
import 'package:razor_expense_tracker_new/src/app/app.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transactions_repository/transactions_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [ TransactionCategorySchema, TransactionSchema],
    directory: dir.path,
  );
  final transactionsApi = LocalStorageTransactionsApi(
    isarDb: isar,
  );

  final transactionRepository = TransactionsRepository(
    transactionsApi: transactionsApi,
  );

  runApp(
    RepositoryProvider(
      create: (context) => transactionRepository,
      child: App(transactionsRepository: transactionRepository),
    ),
  );
}


