// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_category.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionCategoryCollection on Isar {
  IsarCollection<TransactionCategory> get transactionCategorys =>
      this.collection();
}

const TransactionCategorySchema = CollectionSchema(
  name: r'TransactionCategory',
  id: -3276018964472478727,
  properties: {
    r'colorName': PropertySchema(
      id: 0,
      name: r'colorName',
      type: IsarType.string,
    ),
    r'iconCodePoint': PropertySchema(
      id: 1,
      name: r'iconCodePoint',
      type: IsarType.long,
    ),
    r'iconName': PropertySchema(
      id: 2,
      name: r'iconName',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'percentage': PropertySchema(
      id: 4,
      name: r'percentage',
      type: IsarType.string,
    ),
    r'totalAmount': PropertySchema(
      id: 5,
      name: r'totalAmount',
      type: IsarType.long,
    ),
    r'totalExpenseAmount': PropertySchema(
      id: 6,
      name: r'totalExpenseAmount',
      type: IsarType.long,
    ),
    r'totalIncomeAmount': PropertySchema(
      id: 7,
      name: r'totalIncomeAmount',
      type: IsarType.long,
    ),
    r'transactions': PropertySchema(
      id: 8,
      name: r'transactions',
      type: IsarType.objectList,
      target: r'Transaction',
    )
  },
  estimateSize: _transactionCategoryEstimateSize,
  serialize: _transactionCategorySerialize,
  deserialize: _transactionCategoryDeserialize,
  deserializeProp: _transactionCategoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Transaction': TransactionSchema},
  getId: _transactionCategoryGetId,
  getLinks: _transactionCategoryGetLinks,
  attach: _transactionCategoryAttach,
  version: '3.1.0+1',
);

int _transactionCategoryEstimateSize(
  TransactionCategory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.colorName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.iconName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.expensePercentage.length * 3;
  bytesCount += 3 + object.transactions.length * 3;
  {
    final offsets = allOffsets[Transaction]!;
    for (var i = 0; i < object.transactions.length; i++) {
      final value = object.transactions[i];
      bytesCount += TransactionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _transactionCategorySerialize(
  TransactionCategory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.colorName);
  writer.writeLong(offsets[1], object.iconCodePoint);
  writer.writeString(offsets[2], object.iconName);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.expensePercentage);
  writer.writeLong(offsets[5], object.totalAmount);
  writer.writeLong(offsets[6], object.totalExpenseAmount);
  writer.writeLong(offsets[7], object.totalIncomeAmount);
  writer.writeObjectList<Transaction>(
    offsets[8],
    allOffsets,
    TransactionSchema.serialize,
    object.transactions,
  );
}

TransactionCategory _transactionCategoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransactionCategory();
  object.colorName = reader.readStringOrNull(offsets[0]);
  object.iconCodePoint = reader.readLongOrNull(offsets[1]);
  object.iconName = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[3]);
  object.expensePercentage = reader.readString(offsets[4]);
  object.totalAmount = reader.readLong(offsets[5]);
  object.totalExpenseAmount = reader.readLong(offsets[6]);
  object.totalIncomeAmount = reader.readLong(offsets[7]);
  object.transactions = reader.readObjectList<Transaction>(
        offsets[8],
        TransactionSchema.deserialize,
        allOffsets,
        Transaction(),
      ) ??
      [];
  return object;
}

P _transactionCategoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readObjectList<Transaction>(
            offset,
            TransactionSchema.deserialize,
            allOffsets,
            Transaction(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transactionCategoryGetId(TransactionCategory object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _transactionCategoryGetLinks(
    TransactionCategory object) {
  return [];
}

void _transactionCategoryAttach(
    IsarCollection<dynamic> col, Id id, TransactionCategory object) {
  object.id = id;
}

extension TransactionCategoryQueryWhereSort
    on QueryBuilder<TransactionCategory, TransactionCategory, QWhere> {
  QueryBuilder<TransactionCategory, TransactionCategory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransactionCategoryQueryWhere
    on QueryBuilder<TransactionCategory, TransactionCategory, QWhereClause> {
  QueryBuilder<TransactionCategory, TransactionCategory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionCategoryQueryFilter on QueryBuilder<TransactionCategory,
    TransactionCategory, QFilterCondition> {
  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'colorName',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'colorName',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'colorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'colorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      colorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'colorName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconCodePointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconCodePoint',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconCodePointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconCodePoint',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconCodePointEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconCodePointGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconCodePointLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconCodePointBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconCodePoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'iconName',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'iconName',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      iconNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'percentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'percentage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      percentageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'percentage',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalExpenseAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalExpenseAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalExpenseAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalExpenseAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalExpenseAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalExpenseAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalExpenseAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalExpenseAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalIncomeAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalIncomeAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalIncomeAmountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalIncomeAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalIncomeAmountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalIncomeAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      totalIncomeAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalIncomeAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'transactions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'transactions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'transactions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'transactions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'transactions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'transactions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TransactionCategoryQueryObject on QueryBuilder<TransactionCategory,
    TransactionCategory, QFilterCondition> {
  QueryBuilder<TransactionCategory, TransactionCategory, QAfterFilterCondition>
      transactionsElement(FilterQuery<Transaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transactions');
    });
  }
}

extension TransactionCategoryQueryLinks on QueryBuilder<TransactionCategory,
    TransactionCategory, QFilterCondition> {}

extension TransactionCategoryQuerySortBy
    on QueryBuilder<TransactionCategory, TransactionCategory, QSortBy> {
  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByColorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorName', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByColorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorName', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByTotalExpenseAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpenseAmount', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByTotalExpenseAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpenseAmount', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByTotalIncomeAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncomeAmount', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      sortByTotalIncomeAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncomeAmount', Sort.desc);
    });
  }
}

extension TransactionCategoryQuerySortThenBy
    on QueryBuilder<TransactionCategory, TransactionCategory, QSortThenBy> {
  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByColorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorName', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByColorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorName', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconName', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByTotalExpenseAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpenseAmount', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByTotalExpenseAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpenseAmount', Sort.desc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByTotalIncomeAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncomeAmount', Sort.asc);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QAfterSortBy>
      thenByTotalIncomeAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIncomeAmount', Sort.desc);
    });
  }
}

extension TransactionCategoryQueryWhereDistinct
    on QueryBuilder<TransactionCategory, TransactionCategory, QDistinct> {
  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByColorName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconCodePoint');
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByIconName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByPercentage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'percentage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByTotalExpenseAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalExpenseAmount');
    });
  }

  QueryBuilder<TransactionCategory, TransactionCategory, QDistinct>
      distinctByTotalIncomeAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalIncomeAmount');
    });
  }
}

extension TransactionCategoryQueryProperty
    on QueryBuilder<TransactionCategory, TransactionCategory, QQueryProperty> {
  QueryBuilder<TransactionCategory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransactionCategory, String?, QQueryOperations>
      colorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorName');
    });
  }

  QueryBuilder<TransactionCategory, int?, QQueryOperations>
      iconCodePointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconCodePoint');
    });
  }

  QueryBuilder<TransactionCategory, String?, QQueryOperations>
      iconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconName');
    });
  }

  QueryBuilder<TransactionCategory, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TransactionCategory, String, QQueryOperations>
      percentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'percentage');
    });
  }

  QueryBuilder<TransactionCategory, int, QQueryOperations>
      totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }

  QueryBuilder<TransactionCategory, int, QQueryOperations>
      totalExpenseAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalExpenseAmount');
    });
  }

  QueryBuilder<TransactionCategory, int, QQueryOperations>
      totalIncomeAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalIncomeAmount');
    });
  }

  QueryBuilder<TransactionCategory, List<Transaction>, QQueryOperations>
      transactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactions');
    });
  }
}
