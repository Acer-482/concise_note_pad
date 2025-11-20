import 'package:concise_note_pad/filter/match_mode/boolean_match_mode.dart';
import 'package:concise_note_pad/filter/task_field_filtter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boolean_task_filter.g.dart';

/// 布尔字段过滤器
///
/// 允许匹配TaskItem的布尔字段
@JsonSerializable()
class BooleanTaskFilter extends TaskFieldFiltter<bool, bool, BooleanMatchMode> {
  BooleanTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = false,
  });

  factory BooleanTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$BooleanTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$BooleanTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get displayName => '布尔字段过滤器';
  @override
  String get type => 'BooleanTaskFilter';
}
