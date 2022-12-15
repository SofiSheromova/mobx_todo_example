import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  @HiveType(typeId: 0)
  const factory Todo({
    @HiveField(0) required final String id,
    @HiveField(1) required final String description,
    @HiveField(2) required final bool done,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}
