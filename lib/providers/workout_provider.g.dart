// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workoutsHash() => r'e2bc344498952897264c77aacb3e2531bae884db';

/// See also [Workouts].
@ProviderFor(Workouts)
final workoutsProvider =
    AutoDisposeNotifierProvider<Workouts, List<Workout>>.internal(
      Workouts.new,
      name: r'workoutsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$workoutsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Workouts = AutoDisposeNotifier<List<Workout>>;
String _$selectedWorkoutHash() => r'6ebe14ed2b9bd41c82f765269df35b8fa623efe5';

/// See also [SelectedWorkout].
@ProviderFor(SelectedWorkout)
final selectedWorkoutProvider =
    AutoDisposeNotifierProvider<SelectedWorkout, String?>.internal(
      SelectedWorkout.new,
      name: r'selectedWorkoutProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedWorkoutHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedWorkout = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
