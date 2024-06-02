import 'package:isar/isar.dart';
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
  Stream<List<Transaction>> getTransactions() =>
      _transactionsApi.getTransactions();

  ///provides a [Stream] of all categories
  Stream<List<TransactionCategory>> getTransactionCategories() =>
      _transactionsApi.getTransactionCategories();

  ///Provides of [Stream] of all income per [TransactionCategory]
  Stream<List<PieChartDataObject>> getIncomeByCategory() =>
      _transactionsApi.getTransactionsByCategory();

  /// Saves a [Transaction].
  ///
  /// If a [Transaction] with the same id already exists, it will be replaced.
  Future<void> saveTransaction(Transaction transaction) =>
      _transactionsApi.saveTransaction(transaction);

  ///Saves a [Transaction] to a [TransactionCategory]
  Future<void> saveTransactionToCategory(
          Transaction transaction, int categoryId,) =>
      _transactionsApi.saveTransactionToCategory(transaction, categoryId);

  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a [TransactionNotFoundException] error
  /// thrown.
  Future<void> deleteTransaction(Id id) =>
      _transactionsApi.deleteTransaction(id);
}
