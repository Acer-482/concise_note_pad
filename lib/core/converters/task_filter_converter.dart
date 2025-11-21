import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

/// 任务项过滤器转换器
///
/// 添加新的任务项子类时请修改此类
class TaskFilterConverter
    extends JsonConverter<TaskFilter, Map<String, dynamic>> {
  const TaskFilterConverter();

  @override
  TaskFilter fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final TaskFilterRegistration? registration = TaskFilterRegistry.instance
        .getRegistration(type);
    if (registration == null) {
      throw ArgumentError('Unknown filter type: $type');
    } else {
      return registration.fromJson(json);
    }
  }

  @override
  @mustCallSuper
  Map<String, dynamic> toJson(TaskFilter object) {
    return object.toJson();
  }
}
