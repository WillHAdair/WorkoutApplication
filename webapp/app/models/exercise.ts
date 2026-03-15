import type { NamedEntity } from "./base";
import type { Rep } from "./rep";

// The API uses "$type" as the polymorphic discriminator with values like "timed" and "set".
export type ExerciseDiscriminator = "timed" | "set";

export interface ExerciseBase extends NamedEntity {
  scheduleDayId: string;
  startTime?: Date | null;
  $type?: ExerciseDiscriminator;
}

export interface TimedExercise extends ExerciseBase {
  $type: "timed";
  workoutTime: Date; // represented as Date for consistency (timespan/date)
  weight?: number | null;
}

export interface SetExercise extends ExerciseBase {
  $type: "set";
  sets?: Rep[];
  restPeriod?: Date | null;
}

export type Exercise = TimedExercise | SetExercise;
