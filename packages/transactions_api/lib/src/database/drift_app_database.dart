import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_app_database.g.dart';

@DataClassName('LocalTransaction')
/// This is the model for the transactions that are made in the app.
class LocalTransaction extends Table {
  ///Transactions are either expenses or income items class Transaction {

  /// This is the unique identifier for the transaction
  IntColumn get id => integer().autoIncrement()();

  ///This is the amount of the expense
  IntColumn get amount => integer().withDefault(const Constant(0))();

  /// This is the time the expense was instantiated
  DateTime timestamp = DateTime.now();

  /// This is an optional subcategory to be used as a tag for the expense
  String? subCategory;

  /// This is the time the transaction was made.
  DateTimeColumn get dateOfTransaction => dateTime().nullable()();

  /// This is an optional description of the expense.
  TextColumn get description => text().named('description')();

  /// These are user added notes to further understand the expense

  TextColumn get note => text().named('note')();

  /// This is a configuration label that is set if this is an expense.
  BoolColumn get isExpense => boolean().withDefault(const Constant(true))();

  /// This is a configuration label that is set if this is income.
  ///
  BoolColumn get isIncome => boolean().withDefault(const Constant(false))();

  ///This is the category of the transaction
  IntColumn get category =>
      integer().nullable().references(TransactionCategory, #id)();

  @override
  String toString() {
    return 'LocalTransaction{id: $id, ,'
        ' amount: $amount\n,'
        ' timestamp: $timestamp\n, subCategory: $subCategory\n,'
        ' dateOfTransaction: $dateOfTransaction\n,'
        ' description: $description\n, '
        'note: $note\n,'
        ' isExpense: $isExpense\n, '
        ' isIncome: $isIncome\n, '
        'category: $category\n} ';
  }
}

@DataClassName('TransactionCategory')
class TransactionCategory extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get iconName => text()();

  TextColumn get colorName => text()();

  IntColumn get totalAmount => integer().withDefault(const Constant(0))();

  IntColumn get totalExpenseAmount =>
      integer().withDefault(const Constant(0))();

  IntColumn get totalIncomeAmount => integer().withDefault(const Constant(0))();

  @override
  String toString() {
    return 'TransactionCategory{\n'
        'name: $name,\n'
        'iconName: $iconName,\n'
        'colorName: $colorName,\n'
        'totalAmount: $totalAmount,\n'
        'totalExpenseAmount: $totalExpenseAmount,\n'
        'totalIncomeAmount: $totalIncomeAmount,\n'
        '}';
  }
}

@DriftDatabase(tables: [LocalTransaction, TransactionCategory])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

 static LazyDatabase _openConnection() {
    return LazyDatabase(
      () async {
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(p.join(dbFolder.path, 'db.sqlite'));

        if (Platform.isAndroid) {
          await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
        }

        final cachebase = (await getTemporaryDirectory()).path;
        sqlite3.tempDirectory = cachebase;
        return NativeDatabase.createInBackground(file);
      },
    );
  }
}
