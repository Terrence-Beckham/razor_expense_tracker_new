import 'package:isar/isar.dart';
import 'package:transactions_api/src/models/transaction_category.dart';

part 'transaction.g.dart';
@embedded
///Transactions are either expenses or income items
class Transaction {


/// This is the Uuid to identify the transaction
  String? identity ;
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

  String iconName = '';
  String colorName = '';
  String categoryName = '';



  @override
  String toString() {
    return 'Transaction{'
        ' amount: $amount,'
        ' timestamp: $timestamp, '
        ' subCategory: $subCategory,'
        ' dateOfTransaction: $dateOfTransaction, '
        'description: $description,'
        ' note: $note,'
        ' isExpense: $isExpense,'
        ' isIncome: $isIncome}';
  }
}
