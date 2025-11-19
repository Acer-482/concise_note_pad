import 'package:concise_note_pad/filter/task_filter.dart';
import 'package:concise_note_pad/filter/filter_field/text_match_mode.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:concise_note_pad/task_item/field_enum/task_item_text_field.dart';

/// 文本字段匹配器
///
/// 允许匹配TaskItem的文本字段
class TextTaskFilter extends TaskFilter {
  /// 字段 - [TaskItemBooleanField] 枚举值
  ///
  /// 将会匹配[TaskItem]所有可用的字段是否满足条件
  final TaskItemTextField field;

  /// 模式 - [BooleanMatchMode] 枚举值
  ///
  /// 将会在过滤时以该模式来匹配样板
  TextMatchMode mode;

  /// 样板 - [bool] 布尔值
  ///
  /// 将会在匹配时作为样板/条件来过滤内容
  String pattern;

  TextTaskFilter({
    required this.field,
    this.mode = TextMatchMode.exact,
    this.pattern = '',
  });

  @override
  bool matches(TaskItem taskItem) {
    switch (field) {
      case TaskItemTextField.title:
        return _matchesPattern(taskItem.title);
      case TaskItemTextField.subTitle:
        return _matchesPattern(taskItem.subTitle);
      case TaskItemTextField.details:
        return _matchesPattern(taskItem.details);
    }
  }

  /// 根据样板匹配
  bool _matchesPattern(String fieldText) {
    switch (mode) {
      case TextMatchMode.contains:
        return fieldText.contains(pattern);
      case TextMatchMode.exact:
        return fieldText == pattern;
      case TextMatchMode.startsWith:
        return fieldText.startsWith(pattern);
      case TextMatchMode.endsWith:
        return fieldText.endsWith(pattern);
      case TextMatchMode.isEmpty:
        return fieldText.isEmpty;
      case TextMatchMode.isNotEmpty:
        return fieldText.isNotEmpty;
      case TextMatchMode.regex:
        return RegExp(pattern).hasMatch(pattern);
    }
  }
}
