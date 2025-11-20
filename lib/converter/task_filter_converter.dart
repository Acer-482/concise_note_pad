import 'package:concise_note_pad/filter/field_filter/boolean_task_filter.dart';
import 'package:concise_note_pad/filter/field_filter/text_task_filter.dart';
import 'package:concise_note_pad/filter/task_filter.dart';
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
    switch (type) {
      case 'TextFilter':
        return TextTaskFilter.fromJson(json);
      case 'BooleanFilter':
        return BooleanTaskFilter.fromJson(json);
      default:
        throw ArgumentError('Unknown filter type: $type');
    }
  }

  @override
  @mustCallSuper
  Map<String, dynamic> toJson(TaskFilter object) {
    return object.toJson();
  }
}
