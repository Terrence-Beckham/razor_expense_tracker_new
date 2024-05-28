import 'package:isar/isar.dart';
import 'package:transactions_api/src/models/transaction.dart';
part 'transaction_category.g.dart';
@Collection(ignore: {'copyWith'})
class TransactionCategory {
  Id? id;
  String? name;
  String? iconName;
  String? colorName;
  int amount = 0;
  var transactions  = IsarLinks<Transaction>();

  @override
  String toString() {
    return 'TransactionCategory{name: $name, iconName: $iconName, colorName: $colorName , amount: $amount}';
  }
}