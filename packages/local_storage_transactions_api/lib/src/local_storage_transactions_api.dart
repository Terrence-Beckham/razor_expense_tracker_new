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
  late final _transactionStreamController =
      BehaviorSubject<List<Transaction>>.seeded(const []);
  late final _categoryStreamController =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);
  late final _transactionsAmountsPerCategoryStream =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);

  ///Initialize both stream controllers.
  Future<void> init() async {

    await loadDefaultCategories();
    final transactions = await _isarDb.transactions.where().findAll();

    _transactionStreamController.add(transactions);

    final transactionCategories =
        await _isarDb.transactionCategorys.where().findAll();
    _categoryStreamController.add(transactionCategories);
    _logger
        .i('transactionCategories at initialization: $transactionCategories');
  }

  ///This method generates a list of categories from the default categories and adds them to the database
  Future<void> loadDefaultCategories() async {
    final categories =
        await _isarDb.transactionCategorys.where().findAll();
    _logger
        .i('transactionCategories at initialization: $categories');
    if (categories.isEmpty) {
      final categories = defaultCategory;

      await _isarDb.writeTxnSync(() async {
        for (final category in categories) {
          _isarDb.transactionCategorys.putSync(category);
        }
      });

    }
  }

  ///This method deletes a transaction from the database
  @override
  Future<void> deleteTransaction(Id id) async {
    await _isarDb.transactions.delete(id);
  }

  ///This method returns a stream of all transactions
  @override
  Stream<List<Transaction>> getTransactions() {
    return _transactionStreamController.asBroadcastStream();
  }

  /// This method returns a [Stream] of all transaction categories
  @override
  Stream<List<TransactionCategory>> getCategories() {
    return _categoryStreamController.asBroadcastStream();
  }

  ///This method saves a transaction to the database
  @override
  Future<void> saveTransaction(Transaction transaction) async {
    await _isarDb.writeTxnSync(() async {
      _isarDb.transactions.putSync(transaction);
    });
    final transactions = await _isarDb.transactions.where().findAll();
    _transactionStreamController.add(transactions);
  }

  @override
  Future<void> close() {
    _transactionStreamController.close();
    return _categoryStreamController.close();
  }

  @override
  Future<void> saveTransactionToCategory(
      Transaction transaction, int categoryId,) async {
    ///read the transactionCategory from the Database
    final transactionCategory =
        await _isarDb.transactionCategorys.get(categoryId);
    transactionCategory?.transactions.add(transaction);
    await _isarDb.writeTxn(() async {
      await transactionCategory?.transactions.save();

      final transactionCategories =
          await _isarDb.transactionCategorys.where().findAll();
      _categoryStreamController.add(transactionCategories);

      ///recalculate the total amount of expenses by category
    });
  }

  ///This method returns a [Stream] of all transactions by category
  @override
  Stream<List<TransactionCategory>> subscribeToCategoryAmounts() {
    return _transactionsAmountsPerCategoryStream.asBroadcastStream();
  }


}
