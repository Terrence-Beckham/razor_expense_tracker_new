import 'package:isar/isar.dart';
import 'package:transactions_api/src/models/transaction.dart';
import 'package:transactions_api/transactions_api.dart';

part 'transaction_category.g.dart';

@Collection(ignore: {'copyWith'})
class TransactionCategory {
  Id? id;
  String? name;
  String? iconName;
  String? colorName;
  int? iconCodePoint;
  int totalAmount = 0;
  int totalExpenseAmount = 0;
  int totalIncomeAmount = 0;
  String expensePercentage = '';
  String incomePercentage = '';

  // Other properties...

  // Make sure transactions is a growable list
  List<Transaction> transactions = <Transaction>[];

  @override
  String toString() {
    return 'TransactionCategory{id: $id, name: $name, iconName: $iconName, colorName: $colorName,'
        ' iconCodePoint: $iconCodePoint, totalAmount: $totalAmount,'
        ' totalExpenseAmount: $totalExpenseAmount, totalIncomeAmount: $totalIncomeAmount,'
        ' transactions: $transactions, expensePercentage: $expensePercentage, incomePercentage: $incomePercentage}';
  }
}
