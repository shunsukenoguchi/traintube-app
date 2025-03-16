import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
class Workout with _$Workout {
  const factory Workout({
    @Default('') String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
}
