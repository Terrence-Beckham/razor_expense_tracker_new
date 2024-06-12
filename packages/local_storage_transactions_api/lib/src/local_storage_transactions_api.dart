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
  late final _transactionsAmountsPerCategoryStream =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);

  ///Initialize both stream controllers.
  Future<void> init() async {
    await loadDefaultCategories();
    final transactionCategories =
        await _isarDb.transactionCategorys.where().findAll();
    _categoryStreamController.add(transactionCategories);
    _logger
        .i('transactionCategories at initialization: $transactionCategories');
  }

  ///This method generates a list of categories from the default categories and adds them to the database
  Future<void> loadDefaultCategories() async {
    final categories = await _isarDb.transactionCategorys.where().findAll();
    _logger.i('transactionCategories at initialization: $categories');
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
  Future<void> deleteTransaction(Transaction deletedTransaction) async {
    final categories = await _isarDb.transactionCategorys.where().findAll();

    for (final category in categories) {
      final transactions = category.transactions;
      for (final transaction in transactions) {
        if (transaction.identity == deletedTransaction.identity) {
          await _isarDb.writeTxn(() async {
            // category.transactions.remove(transaction);
            category.transactions = List.from(category.transactions)
              ..remove(transaction);
            await _isarDb.transactionCategorys.put(category);
          });
          final categories =
              await _isarDb.transactionCategorys.where().findAll();
          _categoryStreamController.add(categories);
        }
      }
    }
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
  Future<void> saveTransactionToCategory(
    Transaction transaction,
  ) async {
    final category =
        await _isarDb.transactionCategorys.get(transaction.categoryId);

    final transactions = [...?category?.transactions, transaction];
    await _isarDb.writeTxn(() async {
      category?.transactions = transactions;
      await _isarDb.transactionCategorys.put(category!);
    });

    ///todo I need to add it to whatever stream I'm using to display the transactions
    final categories = await _isarDb.transactionCategorys.where().findAll();
    _categoryStreamController.add(categories);
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

  ///This method returns a [Stream] of all transactions by category
  @override
  Stream<List<TransactionCategory>> subscribeToCategoryAmounts() {
    return _transactionsAmountsPerCategoryStream.asBroadcastStream();
  }


}
