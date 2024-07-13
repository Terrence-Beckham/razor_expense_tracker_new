// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_setting.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalSettingCollection on Isar {
  IsarCollection<LocalSetting> get localSettings => this.collection();
}

const LocalSettingSchema = CollectionSchema(
  name: r'LocalSetting',
  id: -7994917054253682846,
  properties: {
    r'adCounterNumber': PropertySchema(
      id: 0,
      name: r'adCounterNumber',
      type: IsarType.long,
    ),
    r'adCounterThreshold': PropertySchema(
      id: 1,
      name: r'adCounterThreshold',
      type: IsarType.long,
    )
  },
  estimateSize: _localSettingEstimateSize,
  serialize: _localSettingSerialize,
  deserialize: _localSettingDeserialize,
  deserializeProp: _localSettingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _localSettingGetId,
  getLinks: _localSettingGetLinks,
  attach: _localSettingAttach,
  version: '3.1.0+1',
);

int _localSettingEstimateSize(
  LocalSetting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _localSettingSerialize(
  LocalSetting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.adCounterNumber);
  writer.writeLong(offsets[1], object.adCounterThreshold);
}

LocalSetting _localSettingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalSetting();
  object.adCounterNumber = reader.readLong(offsets[0]);
  object.adCounterThreshold = reader.readLong(offsets[1]);
  object.id = id;
  return object;
}

P _localSettingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localSettingGetId(LocalSetting object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localSettingGetLinks(LocalSetting object) {
  return [];
}

void _localSettingAttach(
    IsarCollection<dynamic> col, Id id, LocalSetting object) {
  object.id = id;
}

extension LocalSettingQueryWhereSort
    on QueryBuilder<LocalSetting, LocalSetting, QWhere> {
  QueryBuilder<LocalSetting, LocalSetting, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalSettingQueryWhere
    on QueryBuilder<LocalSetting, LocalSetting, QWhereClause> {
  QueryBuilder<LocalSetting, LocalSetting, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<LocalSetting, LocalSetting, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterWhereClause> idBetween(
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

extension LocalSettingQueryFilter
    on QueryBuilder<LocalSetting, LocalSetting, QFilterCondition> {
  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adCounterNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adCounterNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adCounterNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adCounterNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterThresholdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adCounterThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterThresholdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adCounterThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterThresholdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adCounterThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition>
      adCounterThresholdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adCounterThreshold',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<LocalSetting, LocalSetting, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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
}

extension LocalSettingQueryObject
    on QueryBuilder<LocalSetting, LocalSetting, QFilterCondition> {}

extension LocalSettingQueryLinks
    on QueryBuilder<LocalSetting, LocalSetting, QFilterCondition> {}

extension LocalSettingQuerySortBy
    on QueryBuilder<LocalSetting, LocalSetting, QSortBy> {
  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      sortByAdCounterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterNumber', Sort.asc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      sortByAdCounterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterNumber', Sort.desc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      sortByAdCounterThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterThreshold', Sort.asc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      sortByAdCounterThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterThreshold', Sort.desc);
    });
  }
}

extension LocalSettingQuerySortThenBy
    on QueryBuilder<LocalSetting, LocalSetting, QSortThenBy> {
  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      thenByAdCounterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterNumber', Sort.asc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      thenByAdCounterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterNumber', Sort.desc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      thenByAdCounterThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterThreshold', Sort.asc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy>
      thenByAdCounterThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adCounterThreshold', Sort.desc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension LocalSettingQueryWhereDistinct
    on QueryBuilder<LocalSetting, LocalSetting, QDistinct> {
  QueryBuilder<LocalSetting, LocalSetting, QDistinct>
      distinctByAdCounterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adCounterNumber');
    });
  }

  QueryBuilder<LocalSetting, LocalSetting, QDistinct>
      distinctByAdCounterThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adCounterThreshold');
    });
  }
}

extension LocalSettingQueryProperty
    on QueryBuilder<LocalSetting, LocalSetting, QQueryProperty> {
  QueryBuilder<LocalSetting, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalSetting, int, QQueryOperations> adCounterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adCounterNumber');
    });
  }

  QueryBuilder<LocalSetting, int, QQueryOperations>
      adCounterThresholdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adCounterThreshold');
    });
  }
}
