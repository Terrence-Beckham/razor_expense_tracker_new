import 'package:drift_database_api/src/widgets/konstants.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:transactions_api/src/database/drift_app_database.dart';
import 'package:transactions_api/transactions_api.dart'
    hide LocalTransaction
    hide StoredCategory;

/// {@template drift_database_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DriftDatabaseApi extends TransactionsApi {
  /// {@macro drift_database_api}
  DriftDatabaseApi({required AppDatabase appDatabase})
      : _appDatabase = appDatabase,
        _logger = Logger() {
    init();
  }

  final AppDatabase _appDatabase;
  final Logger _logger;
  late final _transactionStreamController =
      BehaviorSubject<List<LocalTransaction>>.seeded(const []);
  late final _storedCategoryStreamController =
      BehaviorSubject<List<TransactionCategory>>.seeded(const []);

  @override
  Future<void> init() async {
    await loadStoredCategories();
  }

  Future<List<TransactionCategory>> getCategories() async {
    final categories =
        _appDatabase.select(_appDatabase.transactionCategory).get();
    return categories;
  }

  @override
  Future<void> loadStoredCategories() async {
    final categories = await getCategories();

    if (categories.isEmpty) {
      final categories = defaultCategory;

      for (final category in categories) {
        await _appDatabase
            .into(_appDatabase.transactionCategory)
            .insert(category);
        // return into(todos).insert(entry);
      }
    }
  }

  //   List<TodoItem> allItems = await database.select(database.todoItems).get();
  @override
  Future<void> addCustomCategory(TransactionCategory category) {
    // TODO: implement addCustomCategory
    throw UnimplementedError();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(LocalTransaction transaction) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> saveTransaction(LocalTransaction transaction) {
    // TODO: implement saveTransaction
    throw UnimplementedError();
  }

  @override
  Stream<List<TransactionCategory>> sortedCategorStream() {
    // TODO: implement sortedCategorStream
    throw UnimplementedError();
  }

  @override
  Stream<List<LocalTransaction>> transactionStream() {
    // TODO: implement transactionStream
    throw UnimplementedError();
  }
}
