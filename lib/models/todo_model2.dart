import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model2.freezed.dart';
part 'todo_model2.g.dart';

@freezed
abstract class TodoModel2 with _$TodoModel2 {
  const factory TodoModel2({
    required String title,
    required bool isCompleted,
    required int priority,
    required String description,
    required DateTime date,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
    required TimeOfDay timeOfDay,
  }) = _TodoModel2;

  factory TodoModel2.fromJson(Map<String, dynamic> json) =>
      _$TodoModel2FromJson(json);
}

// Helper functions cho TimeOfDay
TimeOfDay _timeFromJson(Map<String, dynamic> json) {
  return TimeOfDay(hour: json['hour'] as int, minute: json['minute'] as int);
}

Map<String, dynamic> _timeToJson(TimeOfDay time) {
  return {'hour': time.hour, 'minute': time.minute};
}
