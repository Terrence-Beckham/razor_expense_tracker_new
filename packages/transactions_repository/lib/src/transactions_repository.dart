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
  Stream<List<TransactionCategory>> streamCategories() =>
      _transactionsApi.getCategories();

  ///Saves a [Transaction] to a [TransactionCategory]
  Future<void> saveTransaction(
    Transaction transaction,
    TransactionCategory category,
  ) =>
      _transactionsApi.saveTransaction(transaction, category);
////Resave a deleted Transaction
  Future<void> reSaveTransaction(
    Transaction transaction,
  ) =>
      _transactionsApi.reSaveTransaction(transaction);
  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a [TransactionNotFoundException] error
  /// thrown.
  Future<void> deleteTransaction(Transaction transaction) =>
      _transactionsApi.deleteTransaction(transaction);

  /// Adds a new [TransactionCategory] to the database
  Future<void> addCustomCategory(TransactionCategory category) =>
      _transactionsApi.addCustomCategory(category);
}
