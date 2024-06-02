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
  late final _transactionCategoryStreamController =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);

  ///Initialize both stream controllers.
  Future<void> init() async {
    final transactions = await _isarDb.transactions.where().findAll();

    _transactionStreamController.add(transactions);

    final transactionCategories =
        await _isarDb.transactionCategorys.where().findAll();
    await loadDefaultCategories();
  }

  ///This method generates a list of categories from the default categories and adds them to the database
  Future<void> loadDefaultCategories() async {
    final transactionCategories =
        await _isarDb.transactionCategorys.where().findAll();
    _logger
        .i('transactionCategories at initialization: $transactionCategories');
    if (transactionCategories.isEmpty) {
      final categories = defaultCategory;

      await _isarDb.writeTxnSync(() async {
        for (final category in categories) {
          _isarDb.transactionCategorys.putSync(category);
        }
      });
      final transactionCategories =
          await _isarDb.transactionCategorys.where().findAll();
      _logger.d(
          'These are the transaction categories before being added to the stream $transactionCategories');
      _transactionCategoryStreamController.add(transactionCategories);
    }
    _transactionCategoryStreamController.add(transactionCategories);
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
  Stream<List<TransactionCategory>> getTransactionCategories() {
    return _transactionCategoryStreamController.asBroadcastStream();
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
    return _transactionCategoryStreamController.close();
  }

  @override
  Stream<List<PieChartDataObject>> getTransactionsByCategory() {
    // TODO: implement getTransactionsByCategory
    throw UnimplementedError();
  }

  @override
  Future<void> saveTransactionToCategory(
      Transaction transaction, int categoryId) async {
    ///read the transactionCategory from the Database
    final transactionCategory =
        await _isarDb.transactionCategorys.get(categoryId);
    transactionCategory?.transactions.add(transaction);
    await _isarDb.writeTxn(() async {
      await transactionCategory?.transactions.save();

      final transactionCategories =
          await _isarDb.transactionCategorys.where().findAll();
      _transactionCategoryStreamController.add(transactionCategories);
    });

    // linda.teachers.add(biologyTeacher);
    //
    // await isar.writeTxn(() async {
    //   await linda.teachers.save();
  }
}

//   @override
//   Stream<List<PieChartDataObject>> getTransactionsByCategory() {
//     /// This returns the total amount per category for each expense
// ///todo revist this method when I am ready to build the stats page.
//     return UnimplementedError();
//     final transactions = [..._transactionCategoryStreamController.value];
//     // Create a map to store the total amount for each category
//     final categoryAmounts = <String, double>{};
//
//     // Loop through each expense
//     for (final transaction in transactions) {
//       // Get the category name
//       final categoryName = transaction.name;
//
//       // If the category is not in the map, add it with an initial amount of 0
//       if (!categoryAmounts.containsKey(categoryName)) {
//         categoryAmounts[categoryName!] = 0;
//       }
//
//       // Add the expense amount to the total for that category
//       categoryAmounts[categoryName!] =
//           categoryAmounts[categoryName]! + transaction.amount.toDouble();
//     }
//
//     // Create a new list of PieChartDataObject objects
//     final updatedUniqueCategories = <PieChartDataObject>[];
//
//     for (final categoryName in categoryAmounts.keys) {
//       // Find the expense with the matching category name to get the color
//       final matchingExpense = transactions.firstWhere((index) =>
//       index.name == categoryName);
//
//       updatedUniqueCategories.add(
//         PieChartDataObject(
//           title: categoryName,
//           value: 0, // This can be adjusted if you need a different value here
//           amount: categoryAmounts[categoryName]!,
//           color: matchingExpense.category.color,
//         ),
//       );
//     }
//
//     // Add the new list to the stream controller
//     _transactionCategoryStreamController.add(updatedUniqueCategories);
//   }
