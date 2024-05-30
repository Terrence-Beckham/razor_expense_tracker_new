import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_transactions_api/local_storage_transactions_api.dart';
import 'package:razor_expense_tracker_new/src/app/app.dart';
import 'package:razor_expense_tracker_new/src/home/home.dart';
import 'package:razor_expense_tracker_new/src/transactions_overview/view/transaction_overview.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transactions_repository/transactions_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [TransactionSchema, TransactionCategorySchema],
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

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.transactionsRepository});
  final TransactionsRepository transactionsRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TransactionsOverviewPage(), // Ensure this is the correct initial page
    );
  }
}

