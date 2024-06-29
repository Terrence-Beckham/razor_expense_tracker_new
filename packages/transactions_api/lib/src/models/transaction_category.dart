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

  @Backlink(to: 'category')
  final transactions = IsarLinks<Transaction>();


@override
  String toString() {
    return 'TransactionCategory{\n'
        'id: $id,\n'
        'name: $name,\n'
        'iconName: $iconName,\n'
        'colorName: $colorName,\n'
        'iconCodePoint: $iconCodePoint,\n'
        'totalAmount: $totalAmount,\n'
        'totalExpenseAmount: $totalExpenseAmount,\n'
        'totalIncomeAmount: $totalIncomeAmount,\n'
        'transactions: $transactions,\n'
        'expensePercentage: $expensePercentage,\n'
        'incomePercentage: $incomePercentage\n'
        '}';
  }
}
