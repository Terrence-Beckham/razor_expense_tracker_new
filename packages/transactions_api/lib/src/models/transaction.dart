import 'package:isar/isar.dart';
import 'package:transactions_api/src/models/transaction_category.dart';
import 'package:transactions_api/transactions_api.dart';

part 'transaction.g.dart';

/// This is the model for the transactions that are made in the app.
@collection
class Transaction {
  ///Transactions are either expenses or income items class Transaction {

  /// This is the unique identifier for the transaction
  Id? id;

  /// This is the Uuid to identify the transaction
  /// todo this is to be removed after transitining to  Isar Links
  String? identity;

  ///This is the amount of the expense
  int amount = 0;

  /// This is the time the expense was instantiated
  DateTime timestamp = DateTime.now();

  /// This is an optional subcategory to be used as a tag for the expense
  String? subCategory;

  /// This is the time the transaction was made.
  DateTime dateOfTransaction = DateTime.now();

  /// This is an optional description of the expense.
  String? description;

  /// These are user added notes to further understand the expense
  String? note;

  /// This is a configuration label that is set if this is an expense.
  bool isExpense = true;

  /// This is a configuration label that is set if this is income.
  bool isIncome = false;

  ///This is the category of the transaction
  TransactionCategory? category;

  @override
  String toString() {
    return 'Transaction{id: $id, identity: $identity,'
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
