import 'package:concise_note_pad/features/filters/models/task_filter.dart';
import 'package:flutter/material.dart';

/// 任务过滤器注册项
class TaskFilterRegistration {
  final String type; // 类型
  final String displayName; // 名称
  final String description; // 描述
  final IconData iconData; // 图标

  final TaskFilter Function(Map<String, dynamic> json) fromJson; // 从json创建
  final Map<String, dynamic> Function(TaskFilter item) toJson; // 创建为json

  const TaskFilterRegistration({
    required this.type,
    required this.displayName,
    required this.description,
    required this.iconData,
    required this.toJson,
    required this.fromJson,
  });
}
