import 'package:concise_note_pad/filter/registry/task_filter_registry.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:flutter/material.dart';

/// 任务过滤器抽象基类
///
/// 提供过滤方法 实现此方法可过滤taskItem
abstract class TaskFilter {
  /// 匹配任务
  ///
  /// 当匹配项满足条件时，返回true
  bool matches(TaskItem taskItem);

  String get displayName {
    return TaskFilterRegistry.instance.getRegistration(type)!.displayName;
  }

  String get type;

  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}
