
import 'package:transactions_api/src/models/stored_category.dart';
import 'package:transactions_api/src/models/transaction.dart';

/// {@template transactions_api}
/// The interface and models for an API providing access to transactions.
/// {@endtemplate}

abstract class TransactionsApi {
  /// {@macro todos_api}
  const TransactionsApi();

  /// Provides a [Stream] of all todos.
  Stream<List<Transaction>> transactionStream();

  ///provides a [Stream] of all categories
  Stream<List<StoredCategory>> sortedCategorStream();

  /// Saves a [transaction].
  /// If a [Transaction] with the same id already exists, it will be replaced.

  Future<void> saveTransaction(
    Transaction transaction,
  );

  ///Queries transactions and adds them to the stream
  Future<void> getTransactions();
  


  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a
  /// [TransactionNotFoundException] error is
  /// thrown.
  Future<void> deleteTransaction(Transaction transaction);

  /// Adds a new [StoredCategory] to the database
  Future<void> addCustomCategory(StoredCategory category);

  /// Closes the client and frees up any resources.
  Future<void> close();
}

/// Error thrown when a [Transaction] with a given id is not found.
class TransactionNotFoundException implements Exception {}
