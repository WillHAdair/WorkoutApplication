export type WorkoutCard = {
  id: string;
  name: string;
  timeOfDay?: string;
  exerciseCount: number;
  scheduleName: string;
};

export type ScheduleTemplate = {
  id: string;
  name: string;
  description: string;
  assignedDates: Date[];
};

export type ExerciseTemplate = {
  id: string;
  name: string;
  category: string;
  cues: string;
  repsSummary: string;
};

export const todayWorkoutCards: WorkoutCard[] = [
  {
    id: "w1",
    name: "Upper Body Strength",
    timeOfDay: "07:00",
    exerciseCount: 6,
    scheduleName: "Strength A",
  },
  {
    id: "w2",
    name: "Core + Mobility",
    timeOfDay: "12:30",
    exerciseCount: 4,
    scheduleName: "Mobility",
  },
  {
    id: "w3",
    name: "Evening Run",
    exerciseCount: 2,
    scheduleName: "Cardio",
  },
];

export const scheduleTemplates: ScheduleTemplate[] = [
  {
    id: "s1",
    name: "Strength A",
    description: "Primary compound lifts and upper-body accessories.",
    assignedDates: [new Date("2026-03-16"), new Date("2026-03-18"), new Date("2026-03-20")],
  },
  {
    id: "s2",
    name: "Cardio",
    description: "Easy intervals and steady-state pace work.",
    assignedDates: [new Date("2026-03-17"), new Date("2026-03-19")],
  },
  {
    id: "s3",
    name: "Mobility",
    description: "Core activation and full-body mobility sessions.",
    assignedDates: [new Date("2026-03-15"), new Date("2026-03-21")],
  },
];

export const workoutExercises: ExerciseTemplate[] = [
  {
    id: "e1",
    name: "Bench Press",
    category: "Push",
    cues: "Brace core, drive feet, and control the descent.",
    repsSummary: "3 x 8 @ 135 lb, 90s rest",
  },
  {
    id: "e2",
    name: "Incline Dumbbell Press",
    category: "Push",
    cues: "Neutral wrist and full range of motion.",
    repsSummary: "3 x 10 @ 45 lb, 75s rest",
  },
  {
    id: "e3",
    name: "Plank",
    category: "Core",
    cues: "Keep ribs down and squeeze glutes.",
    repsSummary: "3 x 45 sec hold",
  },
];
