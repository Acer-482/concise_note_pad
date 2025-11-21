import 'package:concise_note_pad/features/filters/enums/match_modes/boolean_match_mode.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filtter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boolean_task_filter.g.dart';

/// 布尔字段过滤器
///
/// 支持匹配任意布尔字段
@JsonSerializable()
class BooleanTaskFilter extends TaskFieldFiltter<bool, bool, BooleanMatchMode> {
  BooleanTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = false,
  });

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
