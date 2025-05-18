// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_day.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScheduleDayCollection on Isar {
  IsarCollection<ScheduleDay> get scheduleDays => this.collection();
}

const ScheduleDaySchema = CollectionSchema(
  name: r'ScheduleDay',
  id: 7724650858087425046,
  properties: {
    r'dayName': PropertySchema(
      id: 0,
      name: r'dayName',
      type: IsarType.string,
    )
  },
  estimateSize: _scheduleDayEstimateSize,
  serialize: _scheduleDaySerialize,
  deserialize: _scheduleDayDeserialize,
  deserializeProp: _scheduleDayDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'workouts': LinkSchema(
      id: -6910556676026276782,
      name: r'workouts',
      target: r'Workout',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _scheduleDayGetId,
  getLinks: _scheduleDayGetLinks,
  attach: _scheduleDayAttach,
  version: '3.1.8',
);

int _scheduleDayEstimateSize(
  ScheduleDay object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dayName.length * 3;
  return bytesCount;
}

void _scheduleDaySerialize(
  ScheduleDay object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dayName);
}

ScheduleDay _scheduleDayDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScheduleDay();
  object.dayName = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _scheduleDayDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _scheduleDayGetId(ScheduleDay object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scheduleDayGetLinks(ScheduleDay object) {
  return [object.workouts];
}

void _scheduleDayAttach(
    IsarCollection<dynamic> col, Id id, ScheduleDay object) {
  object.id = id;
  object.workouts.attach(col, col.isar.collection<Workout>(), r'workouts', id);
}

extension ScheduleDayQueryWhereSort
    on QueryBuilder<ScheduleDay, ScheduleDay, QWhere> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ScheduleDayQueryWhere
    on QueryBuilder<ScheduleDay, ScheduleDay, QWhereClause> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterWhereClause> idBetween(
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

extension ScheduleDayQueryFilter
    on QueryBuilder<ScheduleDay, ScheduleDay, QFilterCondition> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> dayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> dayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> dayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> dayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> dayNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> dayNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> idBetween(
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

extension ScheduleDayQueryObject
    on QueryBuilder<ScheduleDay, ScheduleDay, QFilterCondition> {}

extension ScheduleDayQueryLinks
    on QueryBuilder<ScheduleDay, ScheduleDay, QFilterCondition> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition> workouts(
      FilterQuery<Workout> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'workouts');
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      workoutsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', length, true, length, true);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      workoutsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', 0, true, 0, true);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      workoutsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', 0, false, 999999, true);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      workoutsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', 0, true, length, include);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      workoutsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', length, include, 999999, true);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      workoutsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'workouts', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ScheduleDayQuerySortBy
    on QueryBuilder<ScheduleDay, ScheduleDay, QSortBy> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> sortByDayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayName', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> sortByDayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayName', Sort.desc);
    });
  }
}

extension ScheduleDayQuerySortThenBy
    on QueryBuilder<ScheduleDay, ScheduleDay, QSortThenBy> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByDayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayName', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByDayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayName', Sort.desc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ScheduleDayQueryWhereDistinct
    on QueryBuilder<ScheduleDay, ScheduleDay, QDistinct> {
  QueryBuilder<ScheduleDay, ScheduleDay, QDistinct> distinctByDayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayName', caseSensitive: caseSensitive);
    });
  }
}

extension ScheduleDayQueryProperty
    on QueryBuilder<ScheduleDay, ScheduleDay, QQueryProperty> {
  QueryBuilder<ScheduleDay, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScheduleDay, String, QQueryOperations> dayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayName');
    });
  }
}
