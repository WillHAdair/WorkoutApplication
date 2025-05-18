// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calorie_tracking.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCalorieTrackingCollection on Isar {
  IsarCollection<CalorieTracking> get calorieTrackings => this.collection();
}

const CalorieTrackingSchema = CollectionSchema(
  name: r'CalorieTracking',
  id: -1534180048030922874,
  properties: {
    r'restDayCalories': PropertySchema(
      id: 0,
      name: r'restDayCalories',
      type: IsarType.long,
    ),
    r'workoutDayCalories': PropertySchema(
      id: 1,
      name: r'workoutDayCalories',
      type: IsarType.long,
    )
  },
  estimateSize: _calorieTrackingEstimateSize,
  serialize: _calorieTrackingSerialize,
  deserialize: _calorieTrackingDeserialize,
  deserializeProp: _calorieTrackingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _calorieTrackingGetId,
  getLinks: _calorieTrackingGetLinks,
  attach: _calorieTrackingAttach,
  version: '3.1.8',
);

int _calorieTrackingEstimateSize(
  CalorieTracking object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _calorieTrackingSerialize(
  CalorieTracking object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.restDayCalories);
  writer.writeLong(offsets[1], object.workoutDayCalories);
}

CalorieTracking _calorieTrackingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CalorieTracking();
  object.id = id;
  object.restDayCalories = reader.readLong(offsets[0]);
  object.workoutDayCalories = reader.readLong(offsets[1]);
  return object;
}

P _calorieTrackingDeserializeProp<P>(
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

Id _calorieTrackingGetId(CalorieTracking object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _calorieTrackingGetLinks(CalorieTracking object) {
  return [];
}

void _calorieTrackingAttach(
    IsarCollection<dynamic> col, Id id, CalorieTracking object) {
  object.id = id;
}

extension CalorieTrackingQueryWhereSort
    on QueryBuilder<CalorieTracking, CalorieTracking, QWhere> {
  QueryBuilder<CalorieTracking, CalorieTracking, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CalorieTrackingQueryWhere
    on QueryBuilder<CalorieTracking, CalorieTracking, QWhereClause> {
  QueryBuilder<CalorieTracking, CalorieTracking, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterWhereClause>
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

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterWhereClause> idBetween(
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

extension CalorieTrackingQueryFilter
    on QueryBuilder<CalorieTracking, CalorieTracking, QFilterCondition> {
  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
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

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
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

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
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

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      restDayCaloriesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restDayCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      restDayCaloriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restDayCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      restDayCaloriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restDayCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      restDayCaloriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restDayCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      workoutDayCaloriesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutDayCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      workoutDayCaloriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutDayCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      workoutDayCaloriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutDayCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterFilterCondition>
      workoutDayCaloriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutDayCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CalorieTrackingQueryObject
    on QueryBuilder<CalorieTracking, CalorieTracking, QFilterCondition> {}

extension CalorieTrackingQueryLinks
    on QueryBuilder<CalorieTracking, CalorieTracking, QFilterCondition> {}

extension CalorieTrackingQuerySortBy
    on QueryBuilder<CalorieTracking, CalorieTracking, QSortBy> {
  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      sortByRestDayCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restDayCalories', Sort.asc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      sortByRestDayCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restDayCalories', Sort.desc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      sortByWorkoutDayCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDayCalories', Sort.asc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      sortByWorkoutDayCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDayCalories', Sort.desc);
    });
  }
}

extension CalorieTrackingQuerySortThenBy
    on QueryBuilder<CalorieTracking, CalorieTracking, QSortThenBy> {
  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      thenByRestDayCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restDayCalories', Sort.asc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      thenByRestDayCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restDayCalories', Sort.desc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      thenByWorkoutDayCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDayCalories', Sort.asc);
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QAfterSortBy>
      thenByWorkoutDayCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutDayCalories', Sort.desc);
    });
  }
}

extension CalorieTrackingQueryWhereDistinct
    on QueryBuilder<CalorieTracking, CalorieTracking, QDistinct> {
  QueryBuilder<CalorieTracking, CalorieTracking, QDistinct>
      distinctByRestDayCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restDayCalories');
    });
  }

  QueryBuilder<CalorieTracking, CalorieTracking, QDistinct>
      distinctByWorkoutDayCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutDayCalories');
    });
  }
}

extension CalorieTrackingQueryProperty
    on QueryBuilder<CalorieTracking, CalorieTracking, QQueryProperty> {
  QueryBuilder<CalorieTracking, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CalorieTracking, int, QQueryOperations>
      restDayCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restDayCalories');
    });
  }

  QueryBuilder<CalorieTracking, int, QQueryOperations>
      workoutDayCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutDayCalories');
    });
  }
}
