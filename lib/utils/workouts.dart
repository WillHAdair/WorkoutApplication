import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:workout_app/models/model_base.dart';
import 'package:workout_app/models/workout_set.dart';
import 'package:workout_app/models/storage/workout_set.dart' as prefix;
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/storage/exercise.dart' as prefix;
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/storage/workout.dart'as prefix;
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/storage/schedule_day.dart' as prefix;
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/models/storage/workout_schedule.dart' as prefix;
import 'package:workout_app/utils/conversion_helper.dart';
import 'package:workout_app/utils/database_helper.dart';

class WorkoutsProvider extends ChangeNotifier {
  /// Workout Schedule
  Future<(List<WorkoutSchedule>, ModelBase)> getWorkoutSchedules() async {
    try {
      List<prefix.WorkoutSchedule> databaseSchedules =
          await DatabaseHelper.getAll<prefix.WorkoutSchedule>();
      return (
        databaseSchedules.map((e) => convertWorkoutSchedule(e)).toList(),
        ModelBase(success: true),
      );
    } catch (exception) {
      return (
        <WorkoutSchedule>[],
        ModelBase(success: false, message: exception.toString()),
      );
    }
  }

  Future<(WorkoutSchedule?, ModelBase)> getWorkoutScheduleById(int id) async {
    try {
      prefix.WorkoutSchedule? databaseSchedule = await DatabaseHelper.getById<prefix.WorkoutSchedule>(id);
      if (databaseSchedule == null) {
        return (null, ModelBase(success: false, message: "Workout $id not found"));
      }
      return (convertWorkoutSchedule(databaseSchedule), ModelBase(success: true));
    } catch (exception) {
      return (null, ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<ModelBase> addWorkoutSchedule(WorkoutSchedule schedule) async {
    try {
      final prefixSchedule = convertDataWorkoutSchedule(schedule);
      prefixSchedule.id = Isar.autoIncrement;
      await DatabaseHelper.add<prefix.WorkoutSchedule>(prefixSchedule);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<(WorkoutSchedule?, ModelBase)> updateWorkoutSchedule(WorkoutSchedule schedule) async {
    try {
      final prefixSchedule = convertDataWorkoutSchedule(schedule);
      await DatabaseHelper.update<prefix.WorkoutSchedule>(prefixSchedule);
      notifyListeners();
      return (convertWorkoutSchedule(prefixSchedule), ModelBase(success: true));
    } catch (exception) {
      return (null, ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<ModelBase> deleteWorkoutScheduleById(int id) async {
    try {
      await DatabaseHelper.deleteById<prefix.WorkoutSchedule>(id);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  /// Schedule Days
  Future<(List<ScheduleDay>, ModelBase)> getScheduleDays(int scheduleId) async {
    try {
      final (schedule, _) = await getWorkoutScheduleById(scheduleId);
      if (schedule == null) {
        return (<ScheduleDay>[], ModelBase(success: false, message: "Schedule $scheduleId not found"));
      }
      return (schedule.days, ModelBase(success: true));
    } catch (exception) {
      return (<ScheduleDay>[], ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<(ScheduleDay?, ModelBase)> getScheduleDayById(int id) async {
    try {
      final prefixScheduleDay = await DatabaseHelper.getById<prefix.ScheduleDay>(id);
      if (prefixScheduleDay == null) {
        return (null, ModelBase(success: false, message: "Schedule Day $id not found"));
      }
      ScheduleDay scheduleDay = convertScheduleDay(prefixScheduleDay);
      return (scheduleDay, ModelBase(success: true));
    } catch (exception) {
      return (null, ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<ModelBase> addScheduleDay(int scheduleID, ScheduleDay scheduleDay) async {
    try {
      prefix.WorkoutSchedule? schedule = await DatabaseHelper.getById<prefix.WorkoutSchedule>(scheduleID);
      if (schedule == null) {
        return ModelBase(success: false, message: "Schedule $scheduleID not found");
      }
      scheduleDay.id = Isar.autoIncrement;
      prefix.ScheduleDay scheduleDayData = convertDataScheduleDay(scheduleDay);
      schedule.days.add(scheduleDayData);
      await DatabaseHelper.update<prefix.WorkoutSchedule>(schedule);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> updateScheduleDay(ScheduleDay scheduleDay) async {
    try {
      final prefixScheduleDay = convertDataScheduleDay(scheduleDay);
      await DatabaseHelper.update<prefix.ScheduleDay>(prefixScheduleDay);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> deleteScheduleDayByID(int id) async {
    try {
      await DatabaseHelper.deleteById<prefix.ScheduleDay>(id);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  /// Workouts
  Future<(List<Workout>, ModelBase)> getWorkouts(int scheduleDayID) async {
    try {
      final (scheduleDay, _) = await getScheduleDayById(scheduleDayID);
      if (scheduleDay == null) {
        return (<Workout>[], ModelBase(success: false, message: "Schedule day $scheduleDayID not found"));
      }
      return (scheduleDay.workouts, ModelBase(success: true));
    } catch (exception) {
      return (<Workout>[], ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<(Workout?, ModelBase)> getWorkoutById(int id) async {
    try {
      final prefixWorkout = await DatabaseHelper.getById<prefix.Workout>(id);
      if (prefixWorkout == null) {
        return (null, ModelBase(success: false, message: "Workout $id not found"));
      }
      Workout workout = convertWorkout(prefixWorkout);
      return (workout, ModelBase(success: true));
    } catch (exception) {
      return (null, ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<ModelBase> addWorkout(int scheduleDayID, Workout workout) async {
    try {
      prefix.ScheduleDay? scheduleDay = await DatabaseHelper.getById<prefix.ScheduleDay>(scheduleDayID);
      if (scheduleDay == null) {
        return ModelBase(success: false, message: "Schedule Day $scheduleDayID not found");
      }
      workout.id = Isar.autoIncrement;
      prefix.Workout workoutData = convertDataWorkout(workout);
      scheduleDay.workouts.add(workoutData);
      await DatabaseHelper.update<prefix.ScheduleDay>(scheduleDay);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> updateWorkout(Workout workout) async {
    try {
      final prefixWorkout = convertDataWorkout(workout);
      await DatabaseHelper.update<prefix.Workout>(prefixWorkout);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> deleteWorkoutByID(int id) async {
    try {
      await DatabaseHelper.deleteById<prefix.Workout>(id);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }
  
  /// Exercises
  Future<(List<Exercise>, ModelBase)> getExercises(int workoutID) async {
    try {
      final (workout, _) = await getWorkoutById(workoutID);
      if (workout == null) {
        return (<Exercise>[], ModelBase(success: false, message: "Workout $workoutID not found"));
      }
      return (workout.exercises, ModelBase(success: true));
    } catch (exception) {
      return (<Exercise>[], ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<(Exercise?, ModelBase)> getExerciseById(int id) async {
    try {
      final prefixExercise = await DatabaseHelper.getById<prefix.Exercise>(id);
      if (prefixExercise == null) {
        return (null, ModelBase(success: false, message: "Exercise $id not found"));
      }
      Exercise exercise = convertExercise(prefixExercise);
      return (exercise, ModelBase(success: true));
    } catch (exception) {
      return (null, ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<ModelBase> addExercise(int workoutID, Exercise exercise) async {
    try {
      prefix.Workout? workout = await DatabaseHelper.getById<prefix.Workout>(workoutID);
      if (workout == null) {
        return ModelBase(success: false, message: "Workout $workoutID not found");
      }
      exercise.id = Isar.autoIncrement;
      prefix.Exercise workoutData = convertDataExercise(exercise);
      workout.exercises.add(workoutData);
      await DatabaseHelper.update<prefix.Workout>(workout);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> updateExercise(Exercise exercise) async {
    try {
      final prefixExercise = convertDataExercise(exercise);
      await DatabaseHelper.update<prefix.Exercise>(prefixExercise);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> deleteExerciseById(int id) async {
    try {
      await DatabaseHelper.deleteById<prefix.Exercise>(id);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }
  
  /// Workout Set
  Future<(List<WorkoutSet>, ModelBase)> getWorkoutSets(int exerciseID) async {
    try {
      final (exercise, _) = await getExerciseById(exerciseID);
      if (exercise == null) {
        return (<WorkoutSet>[], ModelBase(success: false, message: "Exercise $exerciseID not found"));
      }
      if (exercise is SetsExercise) {
        return (exercise.sets, ModelBase(success: true));
      }
      return (<WorkoutSet>[], ModelBase(success: false, message: "Exercise $exerciseID does not have sets"));
    } catch (exception) {
      return (<WorkoutSet>[], ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<(WorkoutSet?, ModelBase)> getWorkoutSetById(int id) async {
    try {
      final prefixWorkoutSet = await DatabaseHelper.getById<prefix.WorkoutSet>(id);
      if (prefixWorkoutSet == null) {
        return (null, ModelBase(success: false, message: "Workout Set $id not found"));
      }
      WorkoutSet workoutSet = convertWorkoutSet(prefixWorkoutSet);
      return (workoutSet, ModelBase(success: true));
    } catch (exception) {
      return (null, ModelBase(success: false, message: exception.toString()));
    }
  }

  Future<ModelBase> addWorkoutSet(int exerciseID, WorkoutSet workoutSet) async {
    try {
      prefix.Exercise? exercise = await DatabaseHelper.getById<prefix.Exercise>(exerciseID);
      if (exercise == null) {
        return ModelBase(success: false, message: "Exercise $exerciseID not found");
      }
      workoutSet.id = Isar.autoIncrement;
      prefix.WorkoutSet workoutSetData = convertDataWorkoutSet(workoutSet);
      exercise.workoutSets.add(workoutSetData);
      await DatabaseHelper.update<prefix.Exercise>(exercise);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> updateWorkoutSet(WorkoutSet workoutSet) async {
    try {
      final prefixWorkoutSet = convertDataWorkoutSet(workoutSet);
      await DatabaseHelper.update<prefix.WorkoutSet>(prefixWorkoutSet);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }

  Future<ModelBase> deleteWorkoutSetById(int id) async {
    try {
      await DatabaseHelper.deleteById<prefix.WorkoutSet>(id);
      notifyListeners();
      return ModelBase(success: true);
    } catch (exception) {
      return ModelBase(success: false, message: exception.toString());
    }
  }
}
