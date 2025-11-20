import 'package:concise_note_pad/filter/match_mode/date_time_match_mode.dart';
import 'package:concise_note_pad/filter/task_field_filtter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_time_task_filter.g.dart';

/// 时间字段过滤器
///
/// 允许匹配TaskItem的布尔字段
@JsonSerializable()
class DateTimeTaskFilter
    extends TaskFieldFiltter<DateTime, Duration, DateTimeMatchMode> {
  DateTimeTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = const Duration(seconds: 1),
  });

  factory DateTimeTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$DateTimeTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$DateTimeTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get displayName => '时间字段过滤器';
  @override
  String get type => 'DateTimeTaskFilter';
}
