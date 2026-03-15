import type { NamedEntity } from "./base";
import type { Exercise } from "./exercise";

export interface ScheduleDay extends NamedEntity {
  workoutScheduleId: string;
  exercises?: Exercise[];
}
