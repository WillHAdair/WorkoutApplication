import type { NamedEntity } from "./base";
import type { ScheduleDay } from "./scheduleDay";

export interface WorkoutSchedule extends NamedEntity {
  userId: string; // GUID of owner
  startDate: Date;
  endDate?: Date | null;
  // scheduleDays will typically be loaded separately; include optional relation
  scheduleDays?: ScheduleDay[];
}
