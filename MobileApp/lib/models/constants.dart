enum ImageIcons {
  dumbell,
  bodyWeight,
  timed,
}

enum NutritionIcons {
  fullApple,
  bittenApple,
  halfApple,
  eatenApple,
  overEatenApple,
}

enum WorkoutSetType {
  timed,
  reps,
  dropset
}

enum ExerciseType {
  continual,
  sets,
  circuit
}

enum WorkoutType {
  timed,
  exercises,
}

enum ActivityTracker {
  workoutsCompleted,
  exercisesCompleted,
  caloriesMet,
  workoutsAndCalories,
}

const Map<ActivityTracker, String> trackerMapping = {
  ActivityTracker.workoutsCompleted: 'Workouts Completed',
  ActivityTracker.exercisesCompleted: 'Exercises Completed',
  ActivityTracker.caloriesMet: 'Calorie Goals Met',
  ActivityTracker.workoutsAndCalories: 'Workouts and Calories',
};

// Map to associate enum values with string paths
const Map<ImageIcons, String> imageIconPaths = {
  ImageIcons.dumbell: 'lib/images/icons/dumbell.png',
  ImageIcons.bodyWeight: 'lib/images/icons/bodyweight.png',
  ImageIcons.timed: 'lib/images/icons/timed.png',
};

const Map<NutritionIcons, String> nutritionIconPaths = {
  NutritionIcons.fullApple: 'lib/images/nutrition/apple_full.png',
  NutritionIcons.bittenApple: 'lib/images/nutrition/apple_bite.png',
  NutritionIcons.halfApple: 'lib/images/nutrition/apple_two_bites.png',
  NutritionIcons.eatenApple: 'lib/images/nutrition/apple_core.png',
  NutritionIcons.overEatenApple: 'lib/images/nutrition/apple_overeaten.png',
};