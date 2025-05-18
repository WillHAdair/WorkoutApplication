// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutSetCollection on Isar {
  IsarCollection<WorkoutSet> get workoutSets => this.collection();
}

const WorkoutSetSchema = CollectionSchema(
  name: r'WorkoutSet',
  id: -5974587475565306185,
  properties: {
    r'duration': PropertySchema(
      id: 0,
      name: r'duration',
      type: IsarType.double,
    ),
    r'exercises': PropertySchema(
      id: 1,
      name: r'exercises',
      type: IsarType.longList,
    ),
    r'reps': PropertySchema(
      id: 2,
      name: r'reps',
      type: IsarType.longList,
    ),
    r'restTime': PropertySchema(
      id: 3,
      name: r'restTime',
      type: IsarType.double,
    ),
    r'setType': PropertySchema(
      id: 4,
      name: r'setType',
      type: IsarType.byte,
      enumMap: _WorkoutSetsetTypeEnumValueMap,
    ),
    r'weight': PropertySchema(
      id: 5,
      name: r'weight',
      type: IsarType.double,
    ),
    r'weights': PropertySchema(
      id: 6,
      name: r'weights',
      type: IsarType.doubleList,
    )
  },
  estimateSize: _workoutSetEstimateSize,
  serialize: _workoutSetSerialize,
  deserialize: _workoutSetDeserialize,
  deserializeProp: _workoutSetDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _workoutSetGetId,
  getLinks: _workoutSetGetLinks,
  attach: _workoutSetAttach,
  version: '3.1.8',
);

int _workoutSetEstimateSize(
  WorkoutSet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.exercises;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.reps;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.weights;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _workoutSetSerialize(
  WorkoutSet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.duration);
  writer.writeLongList(offsets[1], object.exercises);
  writer.writeLongList(offsets[2], object.reps);
  writer.writeDouble(offsets[3], object.restTime);
  writer.writeByte(offsets[4], object.setType.index);
  writer.writeDouble(offsets[5], object.weight);
  writer.writeDoubleList(offsets[6], object.weights);
}

WorkoutSet _workoutSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutSet();
  object.duration = reader.readDoubleOrNull(offsets[0]);
  object.exercises = reader.readLongList(offsets[1]);
  object.id = id;
  object.reps = reader.readLongList(offsets[2]);
  object.restTime = reader.readDoubleOrNull(offsets[3]);
  object.setType =
      _WorkoutSetsetTypeValueEnumMap[reader.readByteOrNull(offsets[4])] ??
          SetType.reps;
  object.weight = reader.readDoubleOrNull(offsets[5]);
  object.weights = reader.readDoubleList(offsets[6]);
  return object;
}

P _workoutSetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLongList(offset)) as P;
    case 2:
      return (reader.readLongList(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (_WorkoutSetsetTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          SetType.reps) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _WorkoutSetsetTypeEnumValueMap = {
  'reps': 0,
  'time': 1,
  'superSet': 2,
  'dropSet': 3,
};
const _WorkoutSetsetTypeValueEnumMap = {
  0: SetType.reps,
  1: SetType.time,
  2: SetType.superSet,
  3: SetType.dropSet,
};

Id _workoutSetGetId(WorkoutSet object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutSetGetLinks(WorkoutSet object) {
  return [];
}

void _workoutSetAttach(IsarCollection<dynamic> col, Id id, WorkoutSet object) {
  object.id = id;
}

extension WorkoutSetQueryWhereSort
    on QueryBuilder<WorkoutSet, WorkoutSet, QWhere> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutSetQueryWhere
    on QueryBuilder<WorkoutSet, WorkoutSet, QWhereClause> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterWhereClause> idBetween(
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

extension WorkoutSetQueryFilter
    on QueryBuilder<WorkoutSet, WorkoutSet, QFilterCondition> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> durationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      durationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> durationEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      durationGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> durationLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> durationBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exercises',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exercises',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exercises',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      exercisesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reps',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reps',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> restTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'restTime',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      restTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'restTime',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> restTimeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      restTimeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> restTimeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> restTimeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> setTypeEqualTo(
      SetType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'setType',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      setTypeGreaterThan(
    SetType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'setType',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> setTypeLessThan(
    SetType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'setType',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> setTypeBetween(
    SetType lower,
    SetType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'setType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weights',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weights',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weights',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weights',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weights',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weights',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> weightsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WorkoutSetQueryObject
    on QueryBuilder<WorkoutSet, WorkoutSet, QFilterCondition> {}

extension WorkoutSetQueryLinks
    on QueryBuilder<WorkoutSet, WorkoutSet, QFilterCondition> {}

extension WorkoutSetQuerySortBy
    on QueryBuilder<WorkoutSet, WorkoutSet, QSortBy> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByRestTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByRestTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortBySetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setType', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortBySetTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setType', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension WorkoutSetQuerySortThenBy
    on QueryBuilder<WorkoutSet, WorkoutSet, QSortThenBy> {
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByRestTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByRestTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenBySetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setType', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenBySetTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setType', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension WorkoutSetQueryWhereDistinct
    on QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> {
  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exercises');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reps');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByRestTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restTime');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctBySetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'setType');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByWeights() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weights');
    });
  }
}

extension WorkoutSetQueryProperty
    on QueryBuilder<WorkoutSet, WorkoutSet, QQueryProperty> {
  QueryBuilder<WorkoutSet, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutSet, double?, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<WorkoutSet, List<int>?, QQueryOperations> exercisesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exercises');
    });
  }

  QueryBuilder<WorkoutSet, List<int>?, QQueryOperations> repsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reps');
    });
  }

  QueryBuilder<WorkoutSet, double?, QQueryOperations> restTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restTime');
    });
  }

  QueryBuilder<WorkoutSet, SetType, QQueryOperations> setTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'setType');
    });
  }

  QueryBuilder<WorkoutSet, double?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }

  QueryBuilder<WorkoutSet, List<double>?, QQueryOperations> weightsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weights');
    });
  }
}
