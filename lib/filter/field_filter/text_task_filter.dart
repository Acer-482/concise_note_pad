import 'package:concise_note_pad/filter/task_field_filtter.dart';
import 'package:concise_note_pad/filter/match_mode/text_match_mode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_task_filter.g.dart';

/// 文本字段匹配器
///
/// 允许匹配TaskItem的文本字段
@JsonSerializable()
class TextTaskFilter extends TaskFieldFiltter<String, String, TextMatchMode> {
  TextTaskFilter({
    required super.field,
    required super.mode,
    super.pattern = '',
  });

  factory TextTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$TextTaskFilterFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final superMap = super.toJson();
    superMap.addAll(_$TextTaskFilterToJson(this));
    return superMap;
  }

  @override
  String get displayName => '文本字段匹配器';
  @override
  String get type => 'TextTaskFilter';
}
