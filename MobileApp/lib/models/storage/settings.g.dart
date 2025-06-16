// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSettingsCollection on Isar {
  IsarCollection<Settings> get settings => this.collection();
}

const SettingsSchema = CollectionSchema(
  name: r'Settings',
  id: -8656046621518759136,
  properties: {
    r'isDarkMode': PropertySchema(
      id: 0,
      name: r'isDarkMode',
      type: IsarType.bool,
    ),
    r'selectedOption': PropertySchema(
      id: 1,
      name: r'selectedOption',
      type: IsarType.byte,
      enumMap: _SettingsselectedOptionEnumValueMap,
    ),
    r'showLast30Days': PropertySchema(
      id: 2,
      name: r'showLast30Days',
      type: IsarType.bool,
    )
  },
  estimateSize: _settingsEstimateSize,
  serialize: _settingsSerialize,
  deserialize: _settingsDeserialize,
  deserializeProp: _settingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _settingsGetId,
  getLinks: _settingsGetLinks,
  attach: _settingsAttach,
  version: '3.1.8',
);

int _settingsEstimateSize(
  Settings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _settingsSerialize(
  Settings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isDarkMode);
  writer.writeByte(offsets[1], object.selectedOption.index);
  writer.writeBool(offsets[2], object.showLast30Days);
}

Settings _settingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Settings();
  object.id = id;
  object.isDarkMode = reader.readBool(offsets[0]);
  object.selectedOption =
      _SettingsselectedOptionValueEnumMap[reader.readByteOrNull(offsets[1])] ??
          ActivityTracker.workoutsCompleted;
  object.showLast30Days = reader.readBool(offsets[2]);
  return object;
}

P _settingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (_SettingsselectedOptionValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ActivityTracker.workoutsCompleted) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SettingsselectedOptionEnumValueMap = {
  'workoutsCompleted': 0,
  'exercisesCompleted': 1,
  'caloriesMet': 2,
  'workoutsAndCalories': 3,
};
const _SettingsselectedOptionValueEnumMap = {
  0: ActivityTracker.workoutsCompleted,
  1: ActivityTracker.exercisesCompleted,
  2: ActivityTracker.caloriesMet,
  3: ActivityTracker.workoutsAndCalories,
};

Id _settingsGetId(Settings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingsGetLinks(Settings object) {
  return [];
}

void _settingsAttach(IsarCollection<dynamic> col, Id id, Settings object) {
  object.id = id;
}

extension SettingsQueryWhereSort on QueryBuilder<Settings, Settings, QWhere> {
  QueryBuilder<Settings, Settings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingsQueryWhere on QueryBuilder<Settings, Settings, QWhereClause> {
  QueryBuilder<Settings, Settings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Settings, Settings, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idBetween(
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

extension SettingsQueryFilter
    on QueryBuilder<Settings, Settings, QFilterCondition> {
  QueryBuilder<Settings, Settings, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Settings, Settings, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Settings, Settings, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Settings, Settings, QAfterFilterCondition> isDarkModeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDarkMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> selectedOptionEqualTo(
      ActivityTracker value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedOption',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      selectedOptionGreaterThan(
    ActivityTracker value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedOption',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      selectedOptionLessThan(
    ActivityTracker value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedOption',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> selectedOptionBetween(
    ActivityTracker lower,
    ActivityTracker upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> showLast30DaysEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showLast30Days',
        value: value,
      ));
    });
  }
}

extension SettingsQueryObject
    on QueryBuilder<Settings, Settings, QFilterCondition> {}

extension SettingsQueryLinks
    on QueryBuilder<Settings, Settings, QFilterCondition> {}

extension SettingsQuerySortBy on QueryBuilder<Settings, Settings, QSortBy> {
  QueryBuilder<Settings, Settings, QAfterSortBy> sortByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> sortByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> sortBySelectedOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedOption', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> sortBySelectedOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedOption', Sort.desc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> sortByShowLast30Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLast30Days', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> sortByShowLast30DaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLast30Days', Sort.desc);
    });
  }
}

extension SettingsQuerySortThenBy
    on QueryBuilder<Settings, Settings, QSortThenBy> {
  QueryBuilder<Settings, Settings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenBySelectedOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedOption', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenBySelectedOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedOption', Sort.desc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByShowLast30Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLast30Days', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByShowLast30DaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showLast30Days', Sort.desc);
    });
  }
}

extension SettingsQueryWhereDistinct
    on QueryBuilder<Settings, Settings, QDistinct> {
  QueryBuilder<Settings, Settings, QDistinct> distinctByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDarkMode');
    });
  }

  QueryBuilder<Settings, Settings, QDistinct> distinctBySelectedOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedOption');
    });
  }

  QueryBuilder<Settings, Settings, QDistinct> distinctByShowLast30Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showLast30Days');
    });
  }
}

extension SettingsQueryProperty
    on QueryBuilder<Settings, Settings, QQueryProperty> {
  QueryBuilder<Settings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Settings, bool, QQueryOperations> isDarkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDarkMode');
    });
  }

  QueryBuilder<Settings, ActivityTracker, QQueryOperations>
      selectedOptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedOption');
    });
  }

  QueryBuilder<Settings, bool, QQueryOperations> showLast30DaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showLast30Days');
    });
  }
}
