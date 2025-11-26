import 'package:concise_note_pad/features/task_filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/task_filters/models/task_field_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/task_filter.dart';
import 'package:flutter/material.dart';

/// 任务过滤器注册项
class TaskFilterRegistration {
  /// 类型
  final String type;

  /// 名称
  final String displayName;

  /// 描述
  final String description;

  /// 图标
  final IconData iconData;

  /// 从json创建
  final TaskFilter Function(Map<String, dynamic> json) fromJson;

  /// 创建为json
  final Map<String, dynamic> Function(TaskFilter item) toJson;

  /// 模式枚举列表
  final List<MatchModeMixin> Function()? modeValues;

  /// 构造
  final TaskFieldFilter Function(
    String field,
    MatchModeMixin mode,
    dynamic pattern,
  )?
  buildField;

  const TaskFilterRegistration({
    required this.type,
    required this.displayName,
    required this.description,
    required this.iconData,
    required this.toJson,
    required this.fromJson,
    this.modeValues,
    this.buildField,
  });
}
