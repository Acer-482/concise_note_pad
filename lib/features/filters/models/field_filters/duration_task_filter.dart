import 'package:concise_note_pad/core/utils/string_cast_utils.dart';
import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/enums/match_modes/duration_match_mode.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duration_task_filter.g.dart';

/// 持续时间字段过滤器
///
/// 支持匹配过去或未来指定时间内或外的字段（于当前时间相比）
@JsonSerializable()
class DurationTaskFilter
    extends TaskFieldFilter<DateTime, Duration, DurationMatchMode> {
  DurationTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = Duration.zero,
  });

  @override
  void setPattern(dynamic d) {
    pattern = StringCastUtils.strToDuration(d) ?? Duration.zero;
  }

  @override
  DateTime? fieldCast(field) {
    return StringCastUtils.strToDateTime(field);
  }

  /// 注册
  static void initRegistry() {
    TaskFilterRegistry.instance.register(
      TaskFilterRegistration(
        type: 'DurationTaskFilter',
        displayName: '持续时间字段过滤器',
        description: '支持匹配过去或未来指定时间内或外的字段',
        iconData: Icons.timelapse_rounded,
        toJson: (item) => item.toJson(),
        fromJson: (json) => DurationTaskFilter.fromJson(json),
        modeValues: () => DurationMatchMode.values,
        buildField: (String field, MatchModeMixin mode, dynamic pattern) =>
            DurationTaskFilter(
              field: field,
              mode: mode as DurationMatchMode,
              pattern: StringCastUtils.strToDuration(pattern) ?? Duration.zero,
            ),
      ),
    );
  }

  factory DurationTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$DurationTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$DurationTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get type => 'DurationTaskFilter';
}
