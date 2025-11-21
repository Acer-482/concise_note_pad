import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/models/task_filter.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';

/// 字段过滤器
/// 
/// 样板：
/// [T] - 字段类型
/// [S] - 样板类型
/// [M] - 字段匹配模式混合的实现枚举/类
abstract class TaskFieldFiltter<T, S, M extends MatchModeMixin> extends TaskFilter {
  /// 字段
  ///
  /// 将会解析[TaskItem]中对应字段的值是否满足条件
  T field;

  /// 模式
  ///
  /// 将会在过滤时调用该模式的方法来匹配样板
  M mode;

  /// 样板
  ///
  /// 将会在匹配时作为样板/条件来过滤内容
  S pattern;

  TaskFieldFiltter({
    required this.field,
    required this.mode,
    required this.pattern,
  });

  @override
  bool matches(TaskItem taskItem) {
    return mode.matchesPattern(taskItem.toJson()[field], pattern);
  }
}
