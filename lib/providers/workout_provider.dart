import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/workout.dart';

part 'workout_provider.g.dart';

@riverpod
class Workouts extends _$Workouts {
  @override
  List<Workout> build() {
    return [];
  }

  void add(String name, String description) {
    final now = DateTime.now();
    state = [
      ...state,
      Workout(
        name: name,
        description: description,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  void update(String id, String name, String description) {
    state = [
      for (final workout in state)
        if (workout.id == id)
          workout.copyWith(
            name: name,
            description: description,
            updatedAt: DateTime.now(),
          )
        else
          workout,
    ];
  }

  void remove(String id) {
    state = state.where((workout) => workout.id != id).toList();
  }
}

@riverpod
class SelectedWorkout extends _$SelectedWorkout {
  @override
  String? build() {
    return null;
  }

  void select(String? workoutId) {
    state = workoutId;
  }
}
