/// 任务项文本字段
///
/// 代表任务项的可用布尔字段
enum TaskItemBooleanField {
  isEnabled;

  /// 显示名称
  String get displayName => switch (this) {
    isEnabled => '启用',
  };
}
