// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_app_database.dart';

// ignore_for_file: type=lint
class $TransactionCategoryTable extends TransactionCategory
    with TableInfo<$TransactionCategoryTable, TransactionCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionCategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorNameMeta =
      const VerificationMeta('colorName');
  @override
  late final GeneratedColumn<String> colorName = GeneratedColumn<String>(
      'color_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalExpenseAmountMeta =
      const VerificationMeta('totalExpenseAmount');
  @override
  late final GeneratedColumn<int> totalExpenseAmount = GeneratedColumn<int>(
      'total_expense_amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalIncomeAmountMeta =
      const VerificationMeta('totalIncomeAmount');
  @override
  late final GeneratedColumn<int> totalIncomeAmount = GeneratedColumn<int>(
      'total_income_amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        iconName,
        colorName,
        totalAmount,
        totalExpenseAmount,
        totalIncomeAmount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_category';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    } else if (isInserting) {
      context.missing(_iconNameMeta);
    }
    if (data.containsKey('color_name')) {
      context.handle(_colorNameMeta,
          colorName.isAcceptableOrUnknown(data['color_name']!, _colorNameMeta));
    } else if (isInserting) {
      context.missing(_colorNameMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    }
    if (data.containsKey('total_expense_amount')) {
      context.handle(
          _totalExpenseAmountMeta,
          totalExpenseAmount.isAcceptableOrUnknown(
              data['total_expense_amount']!, _totalExpenseAmountMeta));
    }
    if (data.containsKey('total_income_amount')) {
      context.handle(
          _totalIncomeAmountMeta,
          totalIncomeAmount.isAcceptableOrUnknown(
              data['total_income_amount']!, _totalIncomeAmountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name'])!,
      colorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_name'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_amount'])!,
      totalExpenseAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_expense_amount'])!,
      totalIncomeAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_income_amount'])!,
    );
  }

  @override
  $TransactionCategoryTable createAlias(String alias) {
    return $TransactionCategoryTable(attachedDatabase, alias);
  }
}

class TransactionCategory extends DataClass
    implements Insertable<TransactionCategory> {
  final int id;
  final String name;
  final String iconName;
  final String colorName;
  final int totalAmount;
  final int totalExpenseAmount;
  final int totalIncomeAmount;
  const TransactionCategory(
      {required this.id,
      required this.name,
      required this.iconName,
      required this.colorName,
      required this.totalAmount,
      required this.totalExpenseAmount,
      required this.totalIncomeAmount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon_name'] = Variable<String>(iconName);
    map['color_name'] = Variable<String>(colorName);
    map['total_amount'] = Variable<int>(totalAmount);
    map['total_expense_amount'] = Variable<int>(totalExpenseAmount);
    map['total_income_amount'] = Variable<int>(totalIncomeAmount);
    return map;
  }

  TransactionCategoryCompanion toCompanion(bool nullToAbsent) {
    return TransactionCategoryCompanion(
      id: Value(id),
      name: Value(name),
      iconName: Value(iconName),
      colorName: Value(colorName),
      totalAmount: Value(totalAmount),
      totalExpenseAmount: Value(totalExpenseAmount),
      totalIncomeAmount: Value(totalIncomeAmount),
    );
  }

  factory TransactionCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String>(json['iconName']),
      colorName: serializer.fromJson<String>(json['colorName']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      totalExpenseAmount: serializer.fromJson<int>(json['totalExpenseAmount']),
      totalIncomeAmount: serializer.fromJson<int>(json['totalIncomeAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String>(iconName),
      'colorName': serializer.toJson<String>(colorName),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'totalExpenseAmount': serializer.toJson<int>(totalExpenseAmount),
      'totalIncomeAmount': serializer.toJson<int>(totalIncomeAmount),
    };
  }

  TransactionCategory copyWith(
          {int? id,
          String? name,
          String? iconName,
          String? colorName,
          int? totalAmount,
          int? totalExpenseAmount,
          int? totalIncomeAmount}) =>
      TransactionCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        iconName: iconName ?? this.iconName,
        colorName: colorName ?? this.colorName,
        totalAmount: totalAmount ?? this.totalAmount,
        totalExpenseAmount: totalExpenseAmount ?? this.totalExpenseAmount,
        totalIncomeAmount: totalIncomeAmount ?? this.totalIncomeAmount,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('colorName: $colorName, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('totalExpenseAmount: $totalExpenseAmount, ')
          ..write('totalIncomeAmount: $totalIncomeAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconName, colorName, totalAmount,
      totalExpenseAmount, totalIncomeAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.colorName == this.colorName &&
          other.totalAmount == this.totalAmount &&
          other.totalExpenseAmount == this.totalExpenseAmount &&
          other.totalIncomeAmount == this.totalIncomeAmount);
}

class TransactionCategoryCompanion
    extends UpdateCompanion<TransactionCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> iconName;
  final Value<String> colorName;
  final Value<int> totalAmount;
  final Value<int> totalExpenseAmount;
  final Value<int> totalIncomeAmount;
  const TransactionCategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colorName = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.totalExpenseAmount = const Value.absent(),
    this.totalIncomeAmount = const Value.absent(),
  });
  TransactionCategoryCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String iconName,
    required String colorName,
    this.totalAmount = const Value.absent(),
    this.totalExpenseAmount = const Value.absent(),
    this.totalIncomeAmount = const Value.absent(),
  })  : name = Value(name),
        iconName = Value(iconName),
        colorName = Value(colorName);
  static Insertable<TransactionCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<String>? colorName,
    Expression<int>? totalAmount,
    Expression<int>? totalExpenseAmount,
    Expression<int>? totalIncomeAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (colorName != null) 'color_name': colorName,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (totalExpenseAmount != null)
        'total_expense_amount': totalExpenseAmount,
      if (totalIncomeAmount != null) 'total_income_amount': totalIncomeAmount,
    });
  }

  TransactionCategoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? iconName,
      Value<String>? colorName,
      Value<int>? totalAmount,
      Value<int>? totalExpenseAmount,
      Value<int>? totalIncomeAmount}) {
    return TransactionCategoryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorName: colorName ?? this.colorName,
      totalAmount: totalAmount ?? this.totalAmount,
      totalExpenseAmount: totalExpenseAmount ?? this.totalExpenseAmount,
      totalIncomeAmount: totalIncomeAmount ?? this.totalIncomeAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (colorName.present) {
      map['color_name'] = Variable<String>(colorName.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (totalExpenseAmount.present) {
      map['total_expense_amount'] = Variable<int>(totalExpenseAmount.value);
    }
    if (totalIncomeAmount.present) {
      map['total_income_amount'] = Variable<int>(totalIncomeAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionCategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('colorName: $colorName, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('totalExpenseAmount: $totalExpenseAmount, ')
          ..write('totalIncomeAmount: $totalIncomeAmount')
          ..write(')'))
        .toString();
  }
}

class $LocalTransactionTable extends LocalTransaction
    with TableInfo<$LocalTransactionTable, LocalTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTransactionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dateOfTransactionMeta =
      const VerificationMeta('dateOfTransaction');
  @override
  late final GeneratedColumn<DateTime> dateOfTransaction =
      GeneratedColumn<DateTime>('date_of_transaction', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isExpenseMeta =
      const VerificationMeta('isExpense');
  @override
  late final GeneratedColumn<bool> isExpense = GeneratedColumn<bool>(
      'is_expense', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_expense" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isIncomeMeta =
      const VerificationMeta('isIncome');
  @override
  late final GeneratedColumn<bool> isIncome = GeneratedColumn<bool>(
      'is_income', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_income" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transaction_category (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        amount,
        dateOfTransaction,
        description,
        note,
        isExpense,
        isIncome,
        category
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_transaction';
  @override
  VerificationContext validateIntegrity(Insertable<LocalTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('date_of_transaction')) {
      context.handle(
          _dateOfTransactionMeta,
          dateOfTransaction.isAcceptableOrUnknown(
              data['date_of_transaction']!, _dateOfTransactionMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('is_expense')) {
      context.handle(_isExpenseMeta,
          isExpense.isAcceptableOrUnknown(data['is_expense']!, _isExpenseMeta));
    }
    if (data.containsKey('is_income')) {
      context.handle(_isIncomeMeta,
          isIncome.isAcceptableOrUnknown(data['is_income']!, _isIncomeMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      dateOfTransaction: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_of_transaction']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      isExpense: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_expense'])!,
      isIncome: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_income'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category']),
    );
  }

  @override
  $LocalTransactionTable createAlias(String alias) {
    return $LocalTransactionTable(attachedDatabase, alias);
  }
}

class LocalTransaction extends DataClass
    implements Insertable<LocalTransaction> {
  ///Transactions are either expenses or income items class Transaction {
  /// This is the unique identifier for the transaction
  final int id;

  ///This is the amount of the expense
  final int amount;

  /// This is the time the transaction was made.
  final DateTime? dateOfTransaction;

  /// This is an optional description of the expense.
  final String description;

  /// These are user added notes to further understand the expense
  final String note;

  /// This is a configuration label that is set if this is an expense.
  final bool isExpense;

  /// This is a configuration label that is set if this is income.
  ///
  final bool isIncome;

  ///This is the category of the transaction
  final int? category;
  const LocalTransaction(
      {required this.id,
      required this.amount,
      this.dateOfTransaction,
      required this.description,
      required this.note,
      required this.isExpense,
      required this.isIncome,
      this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || dateOfTransaction != null) {
      map['date_of_transaction'] = Variable<DateTime>(dateOfTransaction);
    }
    map['description'] = Variable<String>(description);
    map['note'] = Variable<String>(note);
    map['is_expense'] = Variable<bool>(isExpense);
    map['is_income'] = Variable<bool>(isIncome);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int>(category);
    }
    return map;
  }

  LocalTransactionCompanion toCompanion(bool nullToAbsent) {
    return LocalTransactionCompanion(
      id: Value(id),
      amount: Value(amount),
      dateOfTransaction: dateOfTransaction == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfTransaction),
      description: Value(description),
      note: Value(note),
      isExpense: Value(isExpense),
      isIncome: Value(isIncome),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory LocalTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTransaction(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      dateOfTransaction:
          serializer.fromJson<DateTime?>(json['dateOfTransaction']),
      description: serializer.fromJson<String>(json['description']),
      note: serializer.fromJson<String>(json['note']),
      isExpense: serializer.fromJson<bool>(json['isExpense']),
      isIncome: serializer.fromJson<bool>(json['isIncome']),
      category: serializer.fromJson<int?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'dateOfTransaction': serializer.toJson<DateTime?>(dateOfTransaction),
      'description': serializer.toJson<String>(description),
      'note': serializer.toJson<String>(note),
      'isExpense': serializer.toJson<bool>(isExpense),
      'isIncome': serializer.toJson<bool>(isIncome),
      'category': serializer.toJson<int?>(category),
    };
  }

  LocalTransaction copyWith(
          {int? id,
          int? amount,
          Value<DateTime?> dateOfTransaction = const Value.absent(),
          String? description,
          String? note,
          bool? isExpense,
          bool? isIncome,
          Value<int?> category = const Value.absent()}) =>
      LocalTransaction(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        dateOfTransaction: dateOfTransaction.present
            ? dateOfTransaction.value
            : this.dateOfTransaction,
        description: description ?? this.description,
        note: note ?? this.note,
        isExpense: isExpense ?? this.isExpense,
        isIncome: isIncome ?? this.isIncome,
        category: category.present ? category.value : this.category,
      );
  @override
  String toString() {
    return (StringBuffer('LocalTransaction(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('dateOfTransaction: $dateOfTransaction, ')
          ..write('description: $description, ')
          ..write('note: $note, ')
          ..write('isExpense: $isExpense, ')
          ..write('isIncome: $isIncome, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, dateOfTransaction, description,
      note, isExpense, isIncome, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTransaction &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.dateOfTransaction == this.dateOfTransaction &&
          other.description == this.description &&
          other.note == this.note &&
          other.isExpense == this.isExpense &&
          other.isIncome == this.isIncome &&
          other.category == this.category);
}

class LocalTransactionCompanion extends UpdateCompanion<LocalTransaction> {
  final Value<int> id;
  final Value<int> amount;
  final Value<DateTime?> dateOfTransaction;
  final Value<String> description;
  final Value<String> note;
  final Value<bool> isExpense;
  final Value<bool> isIncome;
  final Value<int?> category;
  const LocalTransactionCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.dateOfTransaction = const Value.absent(),
    this.description = const Value.absent(),
    this.note = const Value.absent(),
    this.isExpense = const Value.absent(),
    this.isIncome = const Value.absent(),
    this.category = const Value.absent(),
  });
  LocalTransactionCompanion.insert({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.dateOfTransaction = const Value.absent(),
    required String description,
    required String note,
    this.isExpense = const Value.absent(),
    this.isIncome = const Value.absent(),
    this.category = const Value.absent(),
  })  : description = Value(description),
        note = Value(note);
  static Insertable<LocalTransaction> custom({
    Expression<int>? id,
    Expression<int>? amount,
    Expression<DateTime>? dateOfTransaction,
    Expression<String>? description,
    Expression<String>? note,
    Expression<bool>? isExpense,
    Expression<bool>? isIncome,
    Expression<int>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (dateOfTransaction != null) 'date_of_transaction': dateOfTransaction,
      if (description != null) 'description': description,
      if (note != null) 'note': note,
      if (isExpense != null) 'is_expense': isExpense,
      if (isIncome != null) 'is_income': isIncome,
      if (category != null) 'category': category,
    });
  }

  LocalTransactionCompanion copyWith(
      {Value<int>? id,
      Value<int>? amount,
      Value<DateTime?>? dateOfTransaction,
      Value<String>? description,
      Value<String>? note,
      Value<bool>? isExpense,
      Value<bool>? isIncome,
      Value<int?>? category}) {
    return LocalTransactionCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      dateOfTransaction: dateOfTransaction ?? this.dateOfTransaction,
      description: description ?? this.description,
      note: note ?? this.note,
      isExpense: isExpense ?? this.isExpense,
      isIncome: isIncome ?? this.isIncome,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (dateOfTransaction.present) {
      map['date_of_transaction'] = Variable<DateTime>(dateOfTransaction.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isExpense.present) {
      map['is_expense'] = Variable<bool>(isExpense.value);
    }
    if (isIncome.present) {
      map['is_income'] = Variable<bool>(isIncome.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('dateOfTransaction: $dateOfTransaction, ')
          ..write('description: $description, ')
          ..write('note: $note, ')
          ..write('isExpense: $isExpense, ')
          ..write('isIncome: $isIncome, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $TransactionCategoryTable transactionCategory =
      $TransactionCategoryTable(this);
  late final $LocalTransactionTable localTransaction =
      $LocalTransactionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [transactionCategory, localTransaction];
}

typedef $$TransactionCategoryTableInsertCompanionBuilder
    = TransactionCategoryCompanion Function({
  Value<int> id,
  required String name,
  required String iconName,
  required String colorName,
  Value<int> totalAmount,
  Value<int> totalExpenseAmount,
  Value<int> totalIncomeAmount,
});
typedef $$TransactionCategoryTableUpdateCompanionBuilder
    = TransactionCategoryCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> iconName,
  Value<String> colorName,
  Value<int> totalAmount,
  Value<int> totalExpenseAmount,
  Value<int> totalIncomeAmount,
});

class $$TransactionCategoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionCategoryTable,
    TransactionCategory,
    $$TransactionCategoryTableFilterComposer,
    $$TransactionCategoryTableOrderingComposer,
    $$TransactionCategoryTableProcessedTableManager,
    $$TransactionCategoryTableInsertCompanionBuilder,
    $$TransactionCategoryTableUpdateCompanionBuilder> {
  $$TransactionCategoryTableTableManager(
      _$AppDatabase db, $TransactionCategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$TransactionCategoryTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$TransactionCategoryTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TransactionCategoryTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> iconName = const Value.absent(),
            Value<String> colorName = const Value.absent(),
            Value<int> totalAmount = const Value.absent(),
            Value<int> totalExpenseAmount = const Value.absent(),
            Value<int> totalIncomeAmount = const Value.absent(),
          }) =>
              TransactionCategoryCompanion(
            id: id,
            name: name,
            iconName: iconName,
            colorName: colorName,
            totalAmount: totalAmount,
            totalExpenseAmount: totalExpenseAmount,
            totalIncomeAmount: totalIncomeAmount,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String iconName,
            required String colorName,
            Value<int> totalAmount = const Value.absent(),
            Value<int> totalExpenseAmount = const Value.absent(),
            Value<int> totalIncomeAmount = const Value.absent(),
          }) =>
              TransactionCategoryCompanion.insert(
            id: id,
            name: name,
            iconName: iconName,
            colorName: colorName,
            totalAmount: totalAmount,
            totalExpenseAmount: totalExpenseAmount,
            totalIncomeAmount: totalIncomeAmount,
          ),
        ));
}

class $$TransactionCategoryTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $TransactionCategoryTable,
        TransactionCategory,
        $$TransactionCategoryTableFilterComposer,
        $$TransactionCategoryTableOrderingComposer,
        $$TransactionCategoryTableProcessedTableManager,
        $$TransactionCategoryTableInsertCompanionBuilder,
        $$TransactionCategoryTableUpdateCompanionBuilder> {
  $$TransactionCategoryTableProcessedTableManager(super.$state);
}

class $$TransactionCategoryTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TransactionCategoryTable> {
  $$TransactionCategoryTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get iconName => $state.composableBuilder(
      column: $state.table.iconName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorName => $state.composableBuilder(
      column: $state.table.colorName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalAmount => $state.composableBuilder(
      column: $state.table.totalAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalExpenseAmount => $state.composableBuilder(
      column: $state.table.totalExpenseAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalIncomeAmount => $state.composableBuilder(
      column: $state.table.totalIncomeAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter localTransactionRefs(
      ComposableFilter Function($$LocalTransactionTableFilterComposer f) f) {
    final $$LocalTransactionTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.localTransaction,
            getReferencedColumn: (t) => t.category,
            builder: (joinBuilder, parentComposers) =>
                $$LocalTransactionTableFilterComposer(ComposerState($state.db,
                    $state.db.localTransaction, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TransactionCategoryTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TransactionCategoryTable> {
  $$TransactionCategoryTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get iconName => $state.composableBuilder(
      column: $state.table.iconName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorName => $state.composableBuilder(
      column: $state.table.colorName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalAmount => $state.composableBuilder(
      column: $state.table.totalAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalExpenseAmount => $state.composableBuilder(
      column: $state.table.totalExpenseAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalIncomeAmount => $state.composableBuilder(
      column: $state.table.totalIncomeAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LocalTransactionTableInsertCompanionBuilder
    = LocalTransactionCompanion Function({
  Value<int> id,
  Value<int> amount,
  Value<DateTime?> dateOfTransaction,
  required String description,
  required String note,
  Value<bool> isExpense,
  Value<bool> isIncome,
  Value<int?> category,
});
typedef $$LocalTransactionTableUpdateCompanionBuilder
    = LocalTransactionCompanion Function({
  Value<int> id,
  Value<int> amount,
  Value<DateTime?> dateOfTransaction,
  Value<String> description,
  Value<String> note,
  Value<bool> isExpense,
  Value<bool> isIncome,
  Value<int?> category,
});

class $$LocalTransactionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalTransactionTable,
    LocalTransaction,
    $$LocalTransactionTableFilterComposer,
    $$LocalTransactionTableOrderingComposer,
    $$LocalTransactionTableProcessedTableManager,
    $$LocalTransactionTableInsertCompanionBuilder,
    $$LocalTransactionTableUpdateCompanionBuilder> {
  $$LocalTransactionTableTableManager(
      _$AppDatabase db, $LocalTransactionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LocalTransactionTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LocalTransactionTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$LocalTransactionTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime?> dateOfTransaction = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<bool> isExpense = const Value.absent(),
            Value<bool> isIncome = const Value.absent(),
            Value<int?> category = const Value.absent(),
          }) =>
              LocalTransactionCompanion(
            id: id,
            amount: amount,
            dateOfTransaction: dateOfTransaction,
            description: description,
            note: note,
            isExpense: isExpense,
            isIncome: isIncome,
            category: category,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime?> dateOfTransaction = const Value.absent(),
            required String description,
            required String note,
            Value<bool> isExpense = const Value.absent(),
            Value<bool> isIncome = const Value.absent(),
            Value<int?> category = const Value.absent(),
          }) =>
              LocalTransactionCompanion.insert(
            id: id,
            amount: amount,
            dateOfTransaction: dateOfTransaction,
            description: description,
            note: note,
            isExpense: isExpense,
            isIncome: isIncome,
            category: category,
          ),
        ));
}

class $$LocalTransactionTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $LocalTransactionTable,
        LocalTransaction,
        $$LocalTransactionTableFilterComposer,
        $$LocalTransactionTableOrderingComposer,
        $$LocalTransactionTableProcessedTableManager,
        $$LocalTransactionTableInsertCompanionBuilder,
        $$LocalTransactionTableUpdateCompanionBuilder> {
  $$LocalTransactionTableProcessedTableManager(super.$state);
}

class $$LocalTransactionTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LocalTransactionTable> {
  $$LocalTransactionTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateOfTransaction => $state.composableBuilder(
      column: $state.table.dateOfTransaction,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isExpense => $state.composableBuilder(
      column: $state.table.isExpense,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isIncome => $state.composableBuilder(
      column: $state.table.isIncome,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$TransactionCategoryTableFilterComposer get category {
    final $$TransactionCategoryTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.category,
            referencedTable: $state.db.transactionCategory,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TransactionCategoryTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.transactionCategory,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$LocalTransactionTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LocalTransactionTable> {
  $$LocalTransactionTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateOfTransaction => $state.composableBuilder(
      column: $state.table.dateOfTransaction,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isExpense => $state.composableBuilder(
      column: $state.table.isExpense,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isIncome => $state.composableBuilder(
      column: $state.table.isIncome,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$TransactionCategoryTableOrderingComposer get category {
    final $$TransactionCategoryTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.category,
            referencedTable: $state.db.transactionCategory,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$TransactionCategoryTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.transactionCategory,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$TransactionCategoryTableTableManager get transactionCategory =>
      $$TransactionCategoryTableTableManager(_db, _db.transactionCategory);
  $$LocalTransactionTableTableManager get localTransaction =>
      $$LocalTransactionTableTableManager(_db, _db.localTransaction);
}
