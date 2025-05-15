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
    r'dayNumber': PropertySchema(
      id: 0,
      name: r'dayNumber',
      type: IsarType.long,
    ),
    r'isRestDay': PropertySchema(
      id: 1,
      name: r'isRestDay',
      type: IsarType.bool,
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
  return bytesCount;
}

void _scheduleDaySerialize(
  ScheduleDay object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.dayNumber);
  writer.writeBool(offsets[1], object.isRestDay);
}

ScheduleDay _scheduleDayDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScheduleDay();
  object.dayNumber = reader.readLong(offsets[0]);
  object.id = id;
  object.isRestDay = reader.readBool(offsets[1]);
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
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
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
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      dayNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterFilterCondition>
      isRestDayEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRestDay',
        value: value,
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
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> sortByDayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> sortByDayNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.desc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> sortByIsRestDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> sortByIsRestDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.desc);
    });
  }
}

extension ScheduleDayQuerySortThenBy
    on QueryBuilder<ScheduleDay, ScheduleDay, QSortThenBy> {
  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByDayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByDayNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.desc);
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

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByIsRestDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.asc);
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QAfterSortBy> thenByIsRestDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestDay', Sort.desc);
    });
  }
}

extension ScheduleDayQueryWhereDistinct
    on QueryBuilder<ScheduleDay, ScheduleDay, QDistinct> {
  QueryBuilder<ScheduleDay, ScheduleDay, QDistinct> distinctByDayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayNumber');
    });
  }

  QueryBuilder<ScheduleDay, ScheduleDay, QDistinct> distinctByIsRestDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRestDay');
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

  QueryBuilder<ScheduleDay, int, QQueryOperations> dayNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayNumber');
    });
  }

  QueryBuilder<ScheduleDay, bool, QQueryOperations> isRestDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRestDay');
    });
  }
}
