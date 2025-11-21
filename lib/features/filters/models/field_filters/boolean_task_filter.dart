import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/enums/match_modes/boolean_match_mode.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boolean_task_filter.g.dart';

/// 布尔字段过滤器
///
/// 支持匹配任意布尔字段
@JsonSerializable()
class BooleanTaskFilter extends TaskFieldFilter<bool, bool, BooleanMatchMode> {
  BooleanTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = false,
  });

  @override
  set pattern(dynamic pattern) {
    super.pattern = _strToBoolean(pattern);
  }

  /// 字符串转布尔
  static bool _strToBoolean(dynamic v) {
    return v.toString().toLowerCase() == 'true';
  }

  /// 注册
  static void initRegistry() {
    TaskFilterRegistry.instance.register(
      TaskFilterRegistration(
        type: 'BooleanTaskFilter',
        displayName: '布尔字段过滤器',
        description: '支持匹配任意布尔字段',
        iconData: Icons.check_box,
        toJson: (item) => item.toJson(),
        fromJson: (json) => BooleanTaskFilter.fromJson(json),
        modeValues: () => BooleanMatchMode.values,
        buildField: (String field, MatchModeMixin mode, dynamic pattern) =>
            BooleanTaskFilter(
              field: field,
              mode: mode as BooleanMatchMode,
              pattern: _strToBoolean(pattern),
            ),
      ),
    );
  }

  factory BooleanTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$BooleanTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$BooleanTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get type => 'BooleanTaskFilter';
}
