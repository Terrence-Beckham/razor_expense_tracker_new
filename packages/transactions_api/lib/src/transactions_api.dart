import 'package:transactions_api/src/models/transaction.dart';

/// {@template transactions_api}
/// The interface and models for an API providing access to transactions.
/// {@endtemplate}

abstract class TransactionsApi {
  /// {@macro todos_api}
  const TransactionsApi();

  /// Provides a [Stream] of all todos.
  Stream<List<Transaction>> getTransactions();

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

  /// Deletes all completed transactions.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all transactions to the given value.
  ///
  /// Returns the number of updated transactions.
  Future<int> completeAll({required bool isCompleted});

  /// Closes the client and frees up any resources.
  Future<void> close();
}

/// Error thrown when a [Transaction] with a given id is not found.
class TransactionNotFoundException implements Exception {}
