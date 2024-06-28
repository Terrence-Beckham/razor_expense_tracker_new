import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:transactions_api/transactions_api.dart';

import 'konstants.dart';

/// {@template local_storage_transactions_api}
/// A Flutter implementation of the TransactionsApi that uses local storage.
/// {@endtemplate}
class LocalStorageTransactionsApi extends TransactionsApi {
  /// {@macro local_storage_transactions_api}
  LocalStorageTransactionsApi({required Isar isarDb})
      : _isarDb = isarDb,
        _logger = Logger() {
    init();
  }

  final Isar _isarDb;
  final Logger _logger;

  ///todo this has to be removed. leaving it here for now
  late final _transactionStreamController =
      BehaviorSubject<List<Transaction>>.seeded(const []);
  late final _categoryStreamController =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);

  ///Initialize both stream controllers.
  Future<void> init() async {
    await loadDefaultCategories();
    final transactionCategories =
        await _isarDb.transactionCategorys.where().findAll();
    _categoryStreamController.add(transactionCategories);
    final transactions = await _isarDb.transactions.where().findAll();
    _transactionStreamController.add(transactions);
  }

  ///This method generates a list of categories from the default categories and adds them to the database
  Future<void> loadDefaultCategories() async {
    final categories = await _isarDb.transactionCategorys.where().findAll();

    if (categories.isEmpty) {
      final categories = defaultCategory;

      await _isarDb.writeTxn(() async {
        await _isarDb.transactionCategorys.putAll(categories);
      });
    }
  }

  /// This method deletes a transaction from the database
  @override
  Future<void> deleteTransaction(
    Transaction deletedTransaction,
  ) async {
    await _isarDb.writeTxn(() async {
      await _isarDb.transactions.delete(deletedTransaction.id!);
    });
    final transactions = await _isarDb.transactions.where().findAll();
    _transactionStreamController.add(transactions);
  }

  ///This method returns a stream of all transactions
  @override
  Stream<List<Transaction>> getTransactions() {
    return _transactionStreamController.asBroadcastStream();
  }

  ///This method saves a transaction to the database
  @override
  Future<void> saveTransaction(
    Transaction transaction,
    TransactionCategory category,
  ) async {
    await _isarDb.writeTxn(() async {
      await _isarDb.transactions.put(transaction);
      category.transactions.add(transaction);
      transaction.category.value = category;
      await category.transactions.save();
      await transaction.category.save();
    });

    final transactions = await _isarDb.transactions.where().findAll();
    _transactionStreamController.add(transactions);
  }

  @override
  Future<void> reSaveTransaction(Transaction transaction) async {
    final newTransaction = Transaction()
      ..timestamp = transaction.timestamp
      ..amount = transaction.amount
      ..description = transaction.description
      ..isExpense = transaction.isExpense
      ..isIncome = transaction.isIncome;
    newTransaction.category.value = transaction.category.value;

    await _isarDb.writeTxn(() async {
      await _isarDb.transactions.put(newTransaction);
      await newTransaction.category.save();

    });

    final transactions = await _isarDb.transactions.where().findAll();
    _transactionStreamController.add(transactions);
  }

  /// This method returns a [Stream] of all transaction categories
  @override
  Stream<List<TransactionCategory>> getCategories() {
    return _categoryStreamController.asBroadcastStream();
  }

  @override
  Future<void> close() {
    _transactionStreamController.close();
    return _categoryStreamController.close();
  }

  @override
  Future<void> addCustomCategory(TransactionCategory category) async {
    await _isarDb.writeTxn(() async {
      await _isarDb.transactionCategorys.put(category);
    });
    final categories = await _isarDb.transactionCategorys.where().findAll();

    _categoryStreamController.add(categories);
  }
}
