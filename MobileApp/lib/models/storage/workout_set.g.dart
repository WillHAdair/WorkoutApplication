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
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'duration': PropertySchema(
      id: 1,
      name: r'duration',
      type: IsarType.double,
    ),
    r'isBodyWeight': PropertySchema(
      id: 2,
      name: r'isBodyWeight',
      type: IsarType.bool,
    ),
    r'reps': PropertySchema(
      id: 3,
      name: r'reps',
      type: IsarType.long,
    ),
    r'repsList': PropertySchema(
      id: 4,
      name: r'repsList',
      type: IsarType.longList,
    ),
    r'restTime': PropertySchema(
      id: 5,
      name: r'restTime',
      type: IsarType.double,
    ),
    r'setType': PropertySchema(
      id: 6,
      name: r'setType',
      type: IsarType.byte,
      enumMap: _WorkoutSetsetTypeEnumValueMap,
    ),
    r'weight': PropertySchema(
      id: 7,
      name: r'weight',
      type: IsarType.double,
    ),
    r'weightList': PropertySchema(
      id: 8,
      name: r'weightList',
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
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.repsList;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.weightList;
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
  writer.writeString(offsets[0], object.description);
  writer.writeDouble(offsets[1], object.duration);
  writer.writeBool(offsets[2], object.isBodyWeight);
  writer.writeLong(offsets[3], object.reps);
  writer.writeLongList(offsets[4], object.repsList);
  writer.writeDouble(offsets[5], object.restTime);
  writer.writeByte(offsets[6], object.setType.index);
  writer.writeDouble(offsets[7], object.weight);
  writer.writeDoubleList(offsets[8], object.weightList);
}

WorkoutSet _workoutSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutSet();
  object.description = reader.readStringOrNull(offsets[0]);
  object.duration = reader.readDoubleOrNull(offsets[1]);
  object.id = id;
  object.isBodyWeight = reader.readBool(offsets[2]);
  object.reps = reader.readLongOrNull(offsets[3]);
  object.repsList = reader.readLongOrNullList(offsets[4]);
  object.restTime = reader.readDoubleOrNull(offsets[5]);
  object.setType =
      _WorkoutSetsetTypeValueEnumMap[reader.readByteOrNull(offsets[6])] ??
          WorkoutSetType.timed;
  object.weight = reader.readDoubleOrNull(offsets[7]);
  object.weightList = reader.readDoubleList(offsets[8]);
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
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNullList(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (_WorkoutSetsetTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          WorkoutSetType.timed) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _WorkoutSetsetTypeEnumValueMap = {
  'timed': 0,
  'reps': 1,
  'dropset': 2,
};
const _WorkoutSetsetTypeValueEnumMap = {
  0: WorkoutSetType.timed,
  1: WorkoutSetType.reps,
  2: WorkoutSetType.dropset,
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
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      isBodyWeightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBodyWeight',
        value: value,
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsGreaterThan(
    int? value, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsLessThan(
    int? value, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition> repsListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repsList',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repsList',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListElementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNull(
        property: r'repsList',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListElementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNotNull(
        property: r'repsList',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListElementEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repsList',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListElementGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repsList',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListElementLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repsList',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListElementBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repsList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repsList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repsList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repsList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repsList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repsList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      repsListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repsList',
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
      WorkoutSetType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'setType',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      setTypeGreaterThan(
    WorkoutSetType value, {
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
    WorkoutSetType value, {
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
    WorkoutSetType lower,
    WorkoutSetType upper, {
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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightList',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightList',
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightList',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightList',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightList',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weightList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weightList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weightList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weightList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weightList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterFilterCondition>
      weightListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weightList',
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
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByIsBodyWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> sortByRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.desc);
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
  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

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

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByIsBodyWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QAfterSortBy> thenByRepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reps', Sort.desc);
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
  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBodyWeight');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByReps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reps');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByRepsList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repsList');
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

  QueryBuilder<WorkoutSet, WorkoutSet, QDistinct> distinctByWeightList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightList');
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

  QueryBuilder<WorkoutSet, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<WorkoutSet, double?, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<WorkoutSet, bool, QQueryOperations> isBodyWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBodyWeight');
    });
  }

  QueryBuilder<WorkoutSet, int?, QQueryOperations> repsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reps');
    });
  }

  QueryBuilder<WorkoutSet, List<int?>?, QQueryOperations> repsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repsList');
    });
  }

  QueryBuilder<WorkoutSet, double?, QQueryOperations> restTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restTime');
    });
  }

  QueryBuilder<WorkoutSet, WorkoutSetType, QQueryOperations> setTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'setType');
    });
  }

  QueryBuilder<WorkoutSet, double?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }

  QueryBuilder<WorkoutSet, List<double>?, QQueryOperations>
      weightListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightList');
    });
  }
}
