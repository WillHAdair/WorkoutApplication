// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_schedule_day.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPastScheduleDayCollection on Isar {
  IsarCollection<PastScheduleDay> get pastScheduleDays => this.collection();
}

const PastScheduleDaySchema = CollectionSchema(
  name: r'PastScheduleDay',
  id: 2778245088478041436,
  properties: {
    r'caloriesBurned': PropertySchema(
      id: 0,
      name: r'caloriesBurned',
      type: IsarType.double,
    ),
    r'caloriesGoal': PropertySchema(
      id: 1,
      name: r'caloriesGoal',
      type: IsarType.double,
    ),
    r'completionPercentages': PropertySchema(
      id: 2,
      name: r'completionPercentages',
      type: IsarType.doubleList,
    ),
    r'day': PropertySchema(
      id: 3,
      name: r'day',
      type: IsarType.dateTime,
    ),
    r'endTime': PropertySchema(
      id: 4,
      name: r'endTime',
      type: IsarType.string,
    ),
    r'startTime': PropertySchema(
      id: 5,
      name: r'startTime',
      type: IsarType.string,
    )
  },
  estimateSize: _pastScheduleDayEstimateSize,
  serialize: _pastScheduleDaySerialize,
  deserialize: _pastScheduleDayDeserialize,
  deserializeProp: _pastScheduleDayDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'schedule': LinkSchema(
      id: 1839430214610566764,
      name: r'schedule',
      target: r'WorkoutSchedule',
      single: true,
    ),
    r'workouts': LinkSchema(
      id: -5210925839794174666,
      name: r'workouts',
      target: r'Workout',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _pastScheduleDayGetId,
  getLinks: _pastScheduleDayGetLinks,
  attach: _pastScheduleDayAttach,
  version: '3.1.8',
);

int _pastScheduleDayEstimateSize(
  PastScheduleDay object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.completionPercentages;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.endTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.startTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _pastScheduleDaySerialize(
  PastScheduleDay object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.caloriesBurned);
  writer.writeDouble(offsets[1], object.caloriesGoal);
  writer.writeDoubleList(offsets[2], object.completionPercentages);
  writer.writeDateTime(offsets[3], object.day);
  writer.writeString(offsets[4], object.endTime);
  writer.writeString(offsets[5], object.startTime);
}

PastScheduleDay _pastScheduleDayDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PastScheduleDay();
  object.caloriesBurned = reader.readDoubleOrNull(offsets[0]);
  object.caloriesGoal = reader.readDoubleOrNull(offsets[1]);
  object.completionPercentages = reader.readDoubleList(offsets[2]);
  object.day = reader.readDateTime(offsets[3]);
  object.endTime = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.startTime = reader.readStringOrNull(offsets[5]);
  return object;
}

P _pastScheduleDayDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleList(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pastScheduleDayGetId(PastScheduleDay object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pastScheduleDayGetLinks(PastScheduleDay object) {
  return [object.schedule, object.workouts];
}

void _pastScheduleDayAttach(
    IsarCollection<dynamic> col, Id id, PastScheduleDay object) {
  object.id = id;
  object.schedule
      .attach(col, col.isar.collection<WorkoutSchedule>(), r'schedule', id);
  object.workouts.attach(col, col.isar.collection<Workout>(), r'workouts', id);
}

extension PastScheduleDayQueryWhereSort
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QWhere> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PastScheduleDayQueryWhere
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QWhereClause> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterWhereClause>
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

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterWhereClause> idBetween(
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

extension PastScheduleDayQueryFilter
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QFilterCondition> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesBurnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'caloriesBurned',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesBurnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'caloriesBurned',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesBurnedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caloriesBurned',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesBurnedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caloriesBurned',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesBurnedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caloriesBurned',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesBurnedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caloriesBurned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesGoalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'caloriesGoal',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesGoalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'caloriesGoal',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesGoalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caloriesGoal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesGoalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caloriesGoal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesGoalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caloriesGoal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      caloriesGoalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caloriesGoal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completionPercentages',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completionPercentages',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionPercentages',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completionPercentages',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completionPercentages',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completionPercentages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completionPercentages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completionPercentages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completionPercentages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completionPercentages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completionPercentages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      completionPercentagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completionPercentages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      dayEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      dayGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      dayLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      dayBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'day',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: '',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      endTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endTime',
        value: '',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'startTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: '',
      ));
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      startTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'startTime',
        value: '',
      ));
    });
  }
}

extension PastScheduleDayQueryObject
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QFilterCondition> {}

extension PastScheduleDayQueryLinks
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QFilterCondition> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      schedule(FilterQuery<WorkoutSchedule> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'schedule');
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      scheduleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'schedule', 0, true, 0, true);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      workouts(FilterQuery<Workout> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'workouts');
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      workoutsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', length, true, length, true);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      workoutsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', 0, true, 0, true);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      workoutsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', 0, false, 999999, true);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      workoutsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', 0, true, length, include);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
      workoutsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workouts', length, include, 999999, true);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterFilterCondition>
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

extension PastScheduleDayQuerySortBy
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QSortBy> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByCaloriesBurned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesBurned', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByCaloriesBurnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesBurned', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByCaloriesGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesGoal', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByCaloriesGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesGoal', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> sortByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> sortByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension PastScheduleDayQuerySortThenBy
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QSortThenBy> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByCaloriesBurned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesBurned', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByCaloriesBurnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesBurned', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByCaloriesGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesGoal', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByCaloriesGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriesGoal', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> thenByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> thenByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension PastScheduleDayQueryWhereDistinct
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct> {
  QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct>
      distinctByCaloriesBurned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caloriesBurned');
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct>
      distinctByCaloriesGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caloriesGoal');
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct>
      distinctByCompletionPercentages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completionPercentages');
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct> distinctByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'day');
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct> distinctByEndTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PastScheduleDay, PastScheduleDay, QDistinct> distinctByStartTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime', caseSensitive: caseSensitive);
    });
  }
}

extension PastScheduleDayQueryProperty
    on QueryBuilder<PastScheduleDay, PastScheduleDay, QQueryProperty> {
  QueryBuilder<PastScheduleDay, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PastScheduleDay, double?, QQueryOperations>
      caloriesBurnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caloriesBurned');
    });
  }

  QueryBuilder<PastScheduleDay, double?, QQueryOperations>
      caloriesGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caloriesGoal');
    });
  }

  QueryBuilder<PastScheduleDay, List<double>?, QQueryOperations>
      completionPercentagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completionPercentages');
    });
  }

  QueryBuilder<PastScheduleDay, DateTime, QQueryOperations> dayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'day');
    });
  }

  QueryBuilder<PastScheduleDay, String?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<PastScheduleDay, String?, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }
}
