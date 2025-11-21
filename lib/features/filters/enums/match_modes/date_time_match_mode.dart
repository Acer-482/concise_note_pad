import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';

/// 时间字段匹配模式
enum DateTimeMatchMode with MatchModeMixin<DateTime, Duration> {
  exact;

  @override
  String get displayName => switch (this) {
    exact => '精确',
  };

  @override
  bool matchesPattern(fieldValue, pattern) => switch (this) {
    DateTimeMatchMode.exact => fieldValue == pattern,
  };
}
