import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:flutter/material.dart';

/// 任务过滤器抽象基类
///
/// 提供过滤方法 实现此方法可过滤taskItem
abstract class TaskFilter {
  /// 反转条件
  bool isReverse = false;

  /// 过滤器是否有效
  bool isValid = true;

  /// 匹配任务
  ///
  /// 当匹配项满足条件时，返回true
  bool matches(TaskItem taskItem);

  /// 显示名称
  String get displayName {
    return TaskFilterRegistry.instance.getRegistration(type)!.displayName;
  }

  /// 获取类型
  ///
  /// 用于辅助Json
  String get type;

  /// 获取状态
  ///
  /// 用于显示当前过滤器的状态
  String get stateusInfo;

  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}
