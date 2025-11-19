import 'package:concise_note_pad/task_item/task_item.dart';

/// 任务过滤器抽象基类
///
/// 提供过滤方法 实现此方法可过滤taskItem
abstract class TaskFilter {
  bool matches(TaskItem taskItem);

  String get displayName;
  String get type;

  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}
