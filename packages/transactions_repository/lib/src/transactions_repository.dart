import 'package:transactions_api/transactions_api.dart';

/// {@template transactions_repository}
/// A repository that handles transaction related requests.
/// {@endtemplate}

class TransactionsRepo {
  /// {@macro expense_repository}
  const TransactionsRepo({required TransactionsApi transactionsApi})
      : _transactionsApi = transactionsApi;

  final TransactionsApi _transactionsApi;

  /// Provides a [Stream] of all transactions.
  Stream<List<LocalTransaction>> transactionStream() =>
      _transactionsApi.transactionStream();

  ///provides a [Stream] of all categories
  Stream<List<TransactionCategory>> sortedCategoryStream() =>
      _transactionsApi.sortedCategorStream();

  ///Saves a [LocalTransaction] to a [TransactionCategory]
  Future<void> saveTransaction(
    LocalTransaction transaction,
  ) =>
      _transactionsApi.saveTransaction(transaction );

  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a [TransactionNotFoundException] error
  /// thrown.
  Future<void> deleteTransaction(LocalTransaction transaction) =>
      _transactionsApi.deleteTransaction(transaction);

  /// Adds a new [StoredCategory] to the database
  Future<void> addCustomCategory(TransactionCategory category) =>
      _transactionsApi.addCustomCategory(category);

  ///Query transactions
Future<void> getTransactions()=> _transactionsApi.getTransactions();
}
