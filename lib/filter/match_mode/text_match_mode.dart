/// 文本字段匹配模式
enum TextMatchMode {
  contains,
  exact,
  startsWith,
  endsWith,
  isEmpty,
  isNotEmpty,
  regex;

  String get displayName => switch (this) {
    contains => '包含',
    exact => '精确匹配',
    startsWith => '开头匹配',
    endsWith => '结尾匹配',
    isEmpty => '空值',
    isNotEmpty => '非空值',
    regex => '正则表达式',
  };
}
