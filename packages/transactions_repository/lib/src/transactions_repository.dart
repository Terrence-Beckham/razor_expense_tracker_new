import 'package:transactions_api/src/models/transaction.dart';
import 'package:transactions_api/transactions_api.dart';

/// {@template transactions_repository}
/// A repository that handles transaction related requests.
/// {@endtemplate}

class TransactionsRepository {
  /// {@macro expense_repository}
  const TransactionsRepository({required TransactionsApi transactionsApi})
      : _transactionsApi = transactionsApi;

  final TransactionsApi _transactionsApi;

  /// Provides a [Stream] of all transactions.
  Stream<List<Transaction>> getTransactions() => _transactionsApi.getTransactions();

  ///Provides of [Stream] of all expenses per [TransactionCategory]
  Stream<List<PieChartDataObject>> getTransactionsByCategory() =>
      _transactionsApi.getTransactionsByCategory();

  ///Provides of [Stream] of all income per [TransactionCategory]
  Stream<List<PieChartDataObject>> getIncomeByCategory() =>
      _transactionsApi.getTransactionsByCategory();

  /// Saves a [Transaction].
  ///
  /// If a [Transaction] with the same id already exists, it will be replaced.
  Future<void> saveTransaction(Transaction transaction) => _transactionsApi.saveTransaction(transaction);

  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a [TransactionNotFoundException] error
  /// thrown.
  Future<void> deleteTransaction(String id) => _transactionsApi.deleteTransaction(id);
}