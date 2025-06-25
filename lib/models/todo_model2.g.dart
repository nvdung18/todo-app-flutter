// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoModel2 _$TodoModel2FromJson(Map<String, dynamic> json) => _TodoModel2(
  title: json['title'] as String,
  isCompleted: json['isCompleted'] as bool,
  priority: (json['priority'] as num).toInt(),
  description: json['description'] as String,
  date: DateTime.parse(json['date'] as String),
  timeOfDay: _timeFromJson(json['timeOfDay'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TodoModel2ToJson(_TodoModel2 instance) =>
    <String, dynamic>{
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'priority': instance.priority,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'timeOfDay': _timeToJson(instance.timeOfDay),
    };
