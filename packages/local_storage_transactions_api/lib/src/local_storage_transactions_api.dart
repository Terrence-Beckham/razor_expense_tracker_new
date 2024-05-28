import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:transactions_api/transactions_api.dart';

/// {@template local_storage_transactions_api}
/// A Flutter implementation of the TransactionsApi that uses local storage.
/// {@endtemplate}
class LocalStorageTransactionsApi extends TransactionsApi {
  /// {@macro local_storage_transactions_api}
  LocalStorageTransactionsApi({required Isar isarDb}) : _isarDb = isarDb {
    init();
  }

  final Isar _isarDb;
  late final _transactionStreamController =
      BehaviorSubject<List<Transaction>>.seeded(const []);
  late final _transactionCategoryStreamController =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);

  ///Initialize both stream controllers.
  Future<void> init() async {
    final transactions =
        await _isarDb.transactions.where().findAll();

    _transactionStreamController.add(transactions);

    final transactionCategories =
       await _isarDb.transactionCategorys.where().findAll();
    _transactionCategoryStreamController.add(transactionCategories);
  }

  @override
  Future<void> deleteTransaction(String id) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Stream<List<Transaction>> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Stream<List<PieChartDataObject>> getTransactionsByCategory() {
    // TODO: implement getTransactionsByCategory
    throw UnimplementedError();
  }

  @override
  Future<void> saveTransaction(Transaction transaction) {
    // TODO: implement saveTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> close() {
    _transactionStreamController.close();
    return _transactionCategoryStreamController.close();
  }
}
