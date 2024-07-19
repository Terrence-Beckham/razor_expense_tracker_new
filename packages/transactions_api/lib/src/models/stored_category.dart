import 'package:isar/isar.dart';
part 'stored_category.g.dart';


@collection
class StoredCategory{
  Id? id;
  String? name;
  String? iconName;
  String? colorName;



 @override
  String toString() {
    return 'TransactionCategory{\n'
        'name: $name,\n'
        'iconName: $iconName,\n'
        'colorName: $colorName,\n'
        '}';
  }


}
