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
  Stream<List<TransactionCategory>> streamCategories() =>
      _transactionsApi.getCategories();

  ///Calculates the total amount of expenses by category
  ///and adds them to the stream
  Stream<List<TransactionCategory>> subscribeToCategoryAmounts() =>
      _transactionsApi.subscribeToCategoryAmounts();


  ///Saves a [Transaction] to a [TransactionCategory]
  Future<void> saveTransactionToCategory(
      Transaction transaction,) =>
      _transactionsApi.saveTransactionToCategory( transaction);

  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a [TransactionNotFoundException] error
  /// thrown.
  Future<void> deleteTransaction(Transaction  transaction) =>
      _transactionsApi.deleteTransaction(transaction);


  /// Adds a new [TransactionCategory] to the database
  Future<void> addCustomCategory(TransactionCategory category) =>
      _transactionsApi.addCustomCategory(category);

}
