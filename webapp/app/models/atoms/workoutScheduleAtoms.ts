import { atom } from "jotai";
import type { WorkoutSchedule } from "../workoutSchedule";

const allWorkoutSchedulesAtom = atom<WorkoutSchedule[]>([]);
const activeWorkoutSchedulesAtom = atom<WorkoutSchedule[]>([]);

export { allWorkoutSchedulesAtom, activeWorkoutSchedulesAtom };