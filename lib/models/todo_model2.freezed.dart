// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_model2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoModel2 {

 String get title; bool get isCompleted; int get priority; String get description; DateTime get date;@JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) TimeOfDay get timeOfDay;
/// Create a copy of TodoModel2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoModel2CopyWith<TodoModel2> get copyWith => _$TodoModel2CopyWithImpl<TodoModel2>(this as TodoModel2, _$identity);

  /// Serializes this TodoModel2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoModel2&&(identical(other.title, title) || other.title == title)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.timeOfDay, timeOfDay) || other.timeOfDay == timeOfDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,isCompleted,priority,description,date,timeOfDay);

@override
String toString() {
  return 'TodoModel2(title: $title, isCompleted: $isCompleted, priority: $priority, description: $description, date: $date, timeOfDay: $timeOfDay)';
}


}

/// @nodoc
abstract mixin class $TodoModel2CopyWith<$Res>  {
  factory $TodoModel2CopyWith(TodoModel2 value, $Res Function(TodoModel2) _then) = _$TodoModel2CopyWithImpl;
@useResult
$Res call({
 String title, bool isCompleted, int priority, String description, DateTime date,@JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) TimeOfDay timeOfDay
});




}
/// @nodoc
class _$TodoModel2CopyWithImpl<$Res>
    implements $TodoModel2CopyWith<$Res> {
  _$TodoModel2CopyWithImpl(this._self, this._then);

  final TodoModel2 _self;
  final $Res Function(TodoModel2) _then;

/// Create a copy of TodoModel2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? isCompleted = null,Object? priority = null,Object? description = null,Object? date = null,Object? timeOfDay = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,timeOfDay: null == timeOfDay ? _self.timeOfDay : timeOfDay // ignore: cast_nullable_to_non_nullable
as TimeOfDay,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TodoModel2 implements TodoModel2 {
  const _TodoModel2({required this.title, required this.isCompleted, required this.priority, required this.description, required this.date, @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) required this.timeOfDay});
  factory _TodoModel2.fromJson(Map<String, dynamic> json) => _$TodoModel2FromJson(json);

@override final  String title;
@override final  bool isCompleted;
@override final  int priority;
@override final  String description;
@override final  DateTime date;
@override@JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) final  TimeOfDay timeOfDay;

/// Create a copy of TodoModel2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoModel2CopyWith<_TodoModel2> get copyWith => __$TodoModel2CopyWithImpl<_TodoModel2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoModel2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoModel2&&(identical(other.title, title) || other.title == title)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.timeOfDay, timeOfDay) || other.timeOfDay == timeOfDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,isCompleted,priority,description,date,timeOfDay);

@override
String toString() {
  return 'TodoModel2(title: $title, isCompleted: $isCompleted, priority: $priority, description: $description, date: $date, timeOfDay: $timeOfDay)';
}


}

/// @nodoc
abstract mixin class _$TodoModel2CopyWith<$Res> implements $TodoModel2CopyWith<$Res> {
  factory _$TodoModel2CopyWith(_TodoModel2 value, $Res Function(_TodoModel2) _then) = __$TodoModel2CopyWithImpl;
@override @useResult
$Res call({
 String title, bool isCompleted, int priority, String description, DateTime date,@JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) TimeOfDay timeOfDay
});




}
/// @nodoc
class __$TodoModel2CopyWithImpl<$Res>
    implements _$TodoModel2CopyWith<$Res> {
  __$TodoModel2CopyWithImpl(this._self, this._then);

  final _TodoModel2 _self;
  final $Res Function(_TodoModel2) _then;

/// Create a copy of TodoModel2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? isCompleted = null,Object? priority = null,Object? description = null,Object? date = null,Object? timeOfDay = null,}) {
  return _then(_TodoModel2(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,timeOfDay: null == timeOfDay ? _self.timeOfDay : timeOfDay // ignore: cast_nullable_to_non_nullable
as TimeOfDay,
  ));
}


}

// dart format on
