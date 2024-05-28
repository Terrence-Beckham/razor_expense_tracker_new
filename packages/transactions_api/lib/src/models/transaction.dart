import 'package:isar/isar.dart';
import 'package:transactions_api/src/models/transaction_category.dart';

part 'transaction.g.dart';
@Collection(ignore: {'copyWith'}, inheritance: false)
///Transactions are either expenses or income items
class Transaction{

  ///This is a transaction that contains information to be saved
  Transaction({
    required this.amount,
    required this.timestamp,

     required this.dateOfTransaction, required this.isExpense, required this.isIncome, this.subCategory,
     this.description,
     this.note,
  });
  /// This is an id for the Isar Database
  Id?  id ;

  ///This is the amount of the expense
   int amount;
  /// This is the time the expense was instantiated
  DateTime timestamp;
  /// This is the Category that this expense belongs to.
var transactionCategory = IsarLink<TransactionCategory>() ;
  /// This is an optional subcategory to be used as a tag for the expense
  String? subCategory;
  /// This is the time the transaction was made.
  DateTime dateOfTransaction;
  /// This is an optional description of the expense.
  String? description;
  /// These are user added notes to further understand the expense
  String? note;
  /// This is a configuration label that is set if this is an expense.
  bool isExpense = true;
  /// This is a configuration label that is set if this is income.
  bool isIncome;




}
