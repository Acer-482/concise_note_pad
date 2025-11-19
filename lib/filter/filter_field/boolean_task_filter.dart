import 'package:concise_note_pad/filter/filter_field/boolean_match_mode.dart';
import 'package:concise_note_pad/filter/task_filter.dart';
import 'package:concise_note_pad/task_item/field_enum/task_item_boolean_field.dart';
import 'package:concise_note_pad/task_item/task_item.dart';

/// 布尔字段过滤器
///
/// 允许匹配TaskItem的布尔字段
class BooleanTaskFilter extends TaskFilter {
  /// 字段 - [TaskItemBooleanField] 枚举值
  ///
  /// 将会匹配[TaskItem]所有可用的字段是否满足条件
  TaskItemBooleanField field;

  /// 模式 - [BooleanMatchMode] 枚举值
  ///
  /// 将会在过滤时以该模式来匹配样板
  BooleanMatchMode mode;

  /// 样板 - [bool] 布尔值
  ///
  /// 将会在匹配时作为样板/条件来过滤内容
  bool pattern;

  BooleanTaskFilter({
    required this.field,
    required this.mode,
    this.pattern = false,
  });

  @override
  bool matches(TaskItem taskItem) {
    switch (field) {
      case TaskItemBooleanField.isEnabled:
        return _matchesPattern(taskItem.isEnabled);
    }
  }

  /// 根据样板匹配
  bool _matchesPattern(bool fieldValue) {
    switch (mode) {
      case BooleanMatchMode.exact:
        return fieldValue == pattern;
      case BooleanMatchMode.and:
        return fieldValue && pattern;
      case BooleanMatchMode.or:
        return fieldValue || pattern;
      case BooleanMatchMode.not:
        return !fieldValue;
      case BooleanMatchMode.xor:
        return fieldValue ^ pattern;
    }
  }
}
