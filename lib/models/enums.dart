// How to model the Rep Type, (i.e do you do set number of reps, or just time, or go to failure)
enum RepType {
    time,
    counted,
    timeFailure,
    countedFailure,
    warmup,
}

// What is the exercise purpose, this influences how the suggestions regarding weight are discussed
enum ExercisePurpose {
  corrective, //just to keep you going
  cardio,
  hypertrophy,
  warmup //this is different from RepType.warmup because this is the purpose of the entire exercise
}

// Modeling the type of Weight used (i.e is it just the number value, % of 1RM, or not weighted at all)
enum WeightType {
  fixedValue,
  percentORM,
  notApplicable
}