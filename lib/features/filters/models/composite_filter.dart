import 'package:concise_note_pad/core/converters/task_filter_converter.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_filter.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'composite_filter.g.dart';

/// 复合过滤器
///
/// 允许添加多个过滤器 按照逻辑选择过滤
@JsonSerializable()
class CompositeFilter extends TaskFilter {
  /// 过滤器列表
  @TaskFilterConverter()
  List<TaskFilter> filterList;

  /// 与逻辑模式
  ///
  /// 当值为true时，所有过滤器都满足则返回[true]
  ///
  /// 当值为false时，所有过滤器都不满足则返回[false]
  bool isAndLogic;

  /// 注册
  static void initRegistry() {
    TaskFilterRegistry.instance.register(
      TaskFilterRegistration(
        type: 'CompositeFilter',
        displayName: '复合过滤器',
        description: '允许添加多个过滤器 按照逻辑选择过滤',
        iconData: Icons.multitrack_audio,
        toJson: (item) => item.toJson(),
        fromJson: (json) => CompositeFilter.fromJson(json),
      ),
    );
  }

  CompositeFilter({List<TaskFilter>? filterList, this.isAndLogic = false})
    : filterList = filterList ?? [];

  @override
  bool matches(TaskItem taskItem) {
    if (filterList.isEmpty) return true; // 为空则直接满足条件
    if (isAndLogic) {
      for (var filter in filterList) {
        if (!filter.matches(taskItem)) return false;
      }
      return true != isReverse;
    } else {
      for (var filter in filterList) {
        if (filter.matches(taskItem)) return true;
      }
      return false != isReverse;
    }
  }

  factory CompositeFilter.fromJson(Map<String, dynamic> json) =>
      _$CompositeFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$CompositeFilterToJson(this));
    return superMap;
  }

  @override
  String get type => 'CompositeFilter';

  @override
  String get stateusInfo =>
      '逻辑模式：${isAndLogic ? '与' : '或'}，成员数量:"${filterList.length}"${isReverse ? '，已反转' : ''}';
}
