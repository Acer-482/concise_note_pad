import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filtter.dart';
import 'package:concise_note_pad/features/filters/enums/match_modes/text_match_mode.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_task_filter.g.dart';

/// 文本字段匹配器
///
/// 支持匹配任意文本字段，支持正则表达式
@JsonSerializable()
class TextTaskFilter extends TaskFieldFiltter<String, String, TextMatchMode> {
  TextTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = '',
  });

  /// 注册
  static void initRegistry() {
    TaskFilterRegistry.instance.register(
      TaskFilterRegistration(
        type: 'TextTaskFilter',
        displayName: '文本字段匹配器',
        description: '支持匹配任意文本字段，支持正则表达式',
        iconData: Icons.abc,
        toJson: (item) => item.toJson(),
        fromJson: (json) => TextTaskFilter.fromJson(json),
        modeValues: () => TextMatchMode.values,
        buildField: (String field, MatchModeMixin mode, dynamic pattern) =>
            TextTaskFilter(
              field: field,
              mode: mode as TextMatchMode,
              pattern: pattern,
            ),
      ),
    );
  }

  factory TextTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$TextTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$TextTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get type => 'TextTaskFilter';
}
