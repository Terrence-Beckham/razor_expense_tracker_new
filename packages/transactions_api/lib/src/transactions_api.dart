

import 'database/drift_app_database.dart';

/// {@template transactions_api}
/// The interface and models for an API providing access to transactions.
/// {@endtemplate}

abstract class TransactionsApi {
  /// {@macro todos_api}
  const TransactionsApi();

  /// Provides a [Stream] of all todos.
  Stream<List<LocalTransaction>> transactionStream();

  ///provides a [Stream] of all categories
  Stream<List<TransactionCategory>> sortedCategorStream();

  /// Saves a [transaction].
  /// If a [LocalTransaction] with the same id already exists, it will be replaced.

  Future<void> saveTransaction(
    LocalTransaction transaction,
  );

  ///Queries transactions and adds them to the stream
  Future<void> getTransactions();
  


  /// Deletes the `transaction` with the given id.
  ///
  /// If no `transaction` with the given id exists, a
  /// [TransactionNotFoundException] error is
  /// thrown.
  Future<void> deleteTransaction(LocalTransaction transaction);

  /// Adds a new [StoredCategory] to the database
  Future<void> addCustomCategory(TransactionCategory category);

  /// Closes the client and frees up any resources.
  Future<void> close();
///
  Future<void>loadStoredCategories();

  Future<void> init();
}
/// Error thrown when a [LocalTransaction] with a given id is not found.
class TransactionNotFoundException implements Exception {}
