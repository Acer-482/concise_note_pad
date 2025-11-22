import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/models/task_filter.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';

/// 字段过滤器
///
/// 样板：
/// [T] - 字段类型
/// [S] - 样板类型
/// [M] - 字段匹配模式混合的实现枚举/类
abstract class TaskFieldFilter<T, S, M extends MatchModeMixin>
    extends TaskFilter {
  /// 字段名称
  ///
  /// 将会解析类的Json中对应字段的值是否满足条件
  String field;

  /// 模式
  ///
  /// 将会在过滤时调用该模式的方法来匹配样板
  M mode;

  /// 样板
  ///
  /// 将会在匹配时作为样板/条件来过滤内容
  S pattern;

  TaskFieldFilter({
    required this.field,
    required this.mode,
    required this.pattern,
  });

  dynamic getField(TaskItem item) {
    return item.toJson()[field];
  }

  @override
  bool matches(TaskItem taskItem) {
    final field = getField(taskItem);
    // 检测字段是否有效
    if (field == null) {
      // 字段无效
      isValid = false;
      return false;
    } else {
      isValid = true;
    }
    return mode.matchesPattern(field as T, pattern) != isReverse;
  }

  @override
  String get stateusInfo =>
      '${!isValid ? '过滤器字段无效！' : ''}字段: "$field", 样板: "$pattern", 模式: ${mode.displayName}${isReverse ? '，已反转' : ''}';
}
