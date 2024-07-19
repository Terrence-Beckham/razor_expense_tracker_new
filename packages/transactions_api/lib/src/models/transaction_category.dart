import 'package:isar/isar.dart';
part 'transaction_category.g.dart';

@embedded
class TransactionCategory {
  String? name;
 ///todo this can be removed don't need an identity
  String? identity;
  String? iconName;
  String? colorName;
  ///todo don't need codepoint remove!
  int? iconCodePoint;
  int totalAmount = 0;
  int totalExpenseAmount = 0;
  int totalIncomeAmount = 0;
  String expensePercentage = '';
  String incomePercentage = '';



@override
  String toString() {
    return 'TransactionCategory{\n'
        'name: $name,\n'
        'iconName: $iconName,\n'
        'colorName: $colorName,\n'
        'iconCodePoint: $iconCodePoint,\n'
        'totalAmount: $totalAmount,\n'
        'totalExpenseAmount: $totalExpenseAmount,\n'
        'totalIncomeAmount: $totalIncomeAmount,\n'
        'expensePercentage: $expensePercentage,\n'
        'incomePercentage: $incomePercentage\n'
        '}';
  }
}
