import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/enums/match_modes/date_time_match_mode.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_time_task_filter.g.dart';

/// 时间字段过滤器
///
/// 支持匹配任意时间字段
@JsonSerializable()
class DateTimeTaskFilter
    extends TaskFieldFilter<DateTime, Duration, DateTimeMatchMode> {
  DateTimeTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = const Duration(seconds: 1),
  });

  /// 注册
  static void initRegistry() {
    TaskFilterRegistry.instance.register(
      TaskFilterRegistration(
        type: 'DateTimeTaskFilter',
        displayName: '时间字段过滤器',
        description: '支持匹配任意时间字段',
        iconData: Icons.access_time_filled,
        toJson: (item) => item.toJson(),
        fromJson: (json) => DateTimeTaskFilter.fromJson(json),
        modeValues: () => DateTimeMatchMode.values,
        buildField: (String field, MatchModeMixin mode, dynamic pattern) =>
            DateTimeTaskFilter(
              field: field,
              mode: mode as DateTimeMatchMode,
              pattern: pattern,
            ),
      ),
    );
  }

  factory DateTimeTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$DateTimeTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$DateTimeTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get type => 'DateTimeTaskFilter';
}
