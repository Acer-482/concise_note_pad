/// 任务项文本字段
///
/// 代表任务项文本字段的枚举
enum TaskItemTextField {
  title,
  subTitle,
  details;

  String get displayName => switch (this) {
    title => '标题',
    subTitle => '副标题',
    details => '内容',
  };
}
