// ignore_for_file: unused_import

import 'package:transactions_api/src/models/pie_chart_data.dart';
import 'package:transactions_api/src/models/transaction.dart';
import 'package:transactions_api/src/models/transaction_category.dart';

/// {@template transactions_api}
/// The interface and models for an API providing access to transactions.
/// {@endtemplate}

abstract class TransactionsApi {
  /// {@macro todos_api}
  const TransactionsApi();

  /// Provides a [Stream] of all todos.
  Stream<List<Transaction>> getTransactions();
  /// Provides a [Stream] of transactions by category
  Stream<List<PieChartDataObject>> getTransactionsByCategory();

  /// Saves a [transaction].
  ///
  /// If a [Transaction] with the same id already exists, it will be replaced.
  Future<void> saveTransaction(Transaction transaction);

  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a
  /// [TransactionNotFoundException] error is
  /// thrown.
  Future<void> deleteTransaction(String id);




  /// Closes the client and frees up any resources.
  Future<void> close();
}

/// Error thrown when a [Transaction] with a given id is not found.
class TransactionNotFoundException implements Exception {}
