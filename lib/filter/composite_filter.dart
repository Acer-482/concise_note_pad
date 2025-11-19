import 'package:concise_note_pad/filter/task_filter.dart';
import 'package:concise_note_pad/task_item/task_item.dart';

/// 复合过滤器
///
/// 允许添加多个过滤器 按照逻辑选择过滤
class CompositeFilter extends TaskFilter {
  /// 过滤器列表
  List<TaskFilter> filterList;

  /// 与逻辑模式
  ///
  /// 当值为true时，所有过滤器都满足则返回[true]
  ///
  /// 当值为false时，所有过滤器都不满足则返回[false]
  bool isAndLogic;

  CompositeFilter({required this.filterList, required this.isAndLogic});

  @override
  bool matches(TaskItem taskItem) {
    if (isAndLogic) {
      for (var filter in filterList) {
        if (!filter.matches(taskItem)) return false;
      }
      return true;
    } else {
      for (var filter in filterList) {
        if (filter.matches(taskItem)) return true;
      }
      return false;
    }
  }
}
