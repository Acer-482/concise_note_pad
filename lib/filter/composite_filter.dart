import 'package:concise_note_pad/converter/task_filter_converter.dart';
import 'package:concise_note_pad/filter/registry/task_filter_registration.dart';
import 'package:concise_note_pad/filter/registry/task_filter_registry.dart';
import 'package:concise_note_pad/filter/task_filter.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
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

  CompositeFilter({this.filterList = const [], this.isAndLogic = false});

  @override
  bool matches(TaskItem taskItem) {
    if (isAndLogic) {
      for (var filter in filterList) {
        if (!filter.matches(taskItem)) return false;
      }
      return true;
    } else {
      for (var filter in filterList) {
        if (filter.matches(taskItem)) return true;
      }
      return false;
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
}
