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

enum SetType {
  reps,
  time,
}

enum ExerciseType {
  sets,
  continual,
}

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