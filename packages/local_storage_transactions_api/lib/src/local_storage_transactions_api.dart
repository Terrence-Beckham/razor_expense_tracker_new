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
  late final _storedCategoryStreamController =
      BehaviorSubject<List<StoredCategory>>.seeded(const []);

  ///Initialize both stream controllers.
  Future<void> init() async {
    await loadStoredCategories();
    final storedCategories =
        await _isarDb.storedCategorys.where().findAll();
    _storedCategoryStreamController.add(storedCategories);
    ///todo I need to preform my initial query to the stream controller here
    final transactions = await _isarDb.transactions.where().findAll();
    _transactionStreamController.add(transactions);
  }

  ///This method generates a list of categories from the default categories and adds them to the database
  Future<void> loadStoredCategories() async {
    final categories = await _isarDb.storedCategorys.where().findAll();

    if (categories.isEmpty) {
      final categories = defaultCategory;

      await _isarDb.writeTxn(() async {
        await _isarDb.storedCategorys.putAll(categories);
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
  ) async {
    await _isarDb.writeTxn(() async {
      await _isarDb.transactions.put(transaction);
    });
  }

  

  /// This method returns a [Stream] of all transaction categories
  @override
  Stream<List<StoredCategory>> getStoredCategories() {
    return _storedCategoryStreamController.asBroadcastStream();
  }

  @override
  Future<void> close() {
    _transactionStreamController.close();
    return _storedCategoryStreamController.close();
  }

  @override
  Future<void> addCustomCategory(StoredCategory category) async {
    await _isarDb.writeTxn(() async {
      await _isarDb.storedCategorys.put(category);
    });
    final categories = await _isarDb.storedCategorys.where().findAll();

    _storedCategoryStreamController.add(categories);
  }
}
