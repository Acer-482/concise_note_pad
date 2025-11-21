import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';

/// 布尔字段匹配模式
enum BooleanMatchMode with MatchModeMixin<bool, bool> {
  exact,
  and,
  or,
  not,
  xor;

  @override
  String get displayName => switch (this) {
    exact => '精确',
    and => '与逻辑',
    or => '或逻辑',
    not => '非逻辑',
    xor => '异或逻辑',
  };

  @override
  List<MatchModeMixin> get mixinValues => values;

  @override
  bool matchesPattern(fieldValue, pattern) => switch (this) {
    BooleanMatchMode.exact => fieldValue == pattern,
    BooleanMatchMode.and => fieldValue && pattern,
    BooleanMatchMode.or => fieldValue || pattern,
    BooleanMatchMode.not => !fieldValue,
    BooleanMatchMode.xor => fieldValue ^ pattern,
  };
}
