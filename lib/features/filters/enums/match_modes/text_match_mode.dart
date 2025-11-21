import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';

/// 文本字段匹配模式
enum TextMatchMode with MatchModeMixin<String, String> {
  contains,
  exact,
  startsWith,
  endsWith,
  isEmpty,
  isNotEmpty,
  regex;

  @override
  String get displayName => switch (this) {
    contains => '包含',
    exact => '精确匹配',
    startsWith => '开头匹配',
    endsWith => '结尾匹配',
    isEmpty => '空值',
    isNotEmpty => '非空值',
    regex => '正则表达式',
  };

  @override
  List<MatchModeMixin> get mixinValues => values;
  
  @override
  bool matchesPattern(fieldText, pattern) => switch (this) {
    TextMatchMode.contains => fieldText.contains(pattern),
    TextMatchMode.exact => fieldText == pattern,
    TextMatchMode.startsWith => fieldText.startsWith(pattern),
    TextMatchMode.endsWith => fieldText.endsWith(pattern),
    TextMatchMode.isEmpty => fieldText.isEmpty,
    TextMatchMode.isNotEmpty => fieldText.isNotEmpty,
    TextMatchMode.regex => RegExp(pattern).hasMatch(fieldText),
  };
}
