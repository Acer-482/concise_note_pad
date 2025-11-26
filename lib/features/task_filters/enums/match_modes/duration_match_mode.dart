import 'package:concise_note_pad/features/task_filters/enums/match_mode_mixin.dart';

/// 持续时间字段匹配模式
enum DurationMatchMode with MatchModeMixin<DateTime, Duration> {
  within,
  withinInLast,
  withinInNext,
  without,
  withoutInLast,
  withoutInNext;

  @override
  String get displayName => switch (this) {
    within => '在时间之内',
    withinInLast => '在过去时间之内',
    withinInNext => '在未来时间之内',
    without => '在时间之外',
    withoutInLast => '在过去时间之外',
    withoutInNext => '在未来时间之外',
  };

  @override
  List<MatchModeMixin> get mixinValues => values;

  @override
  bool matchesPattern(DateTime fieldValue, Duration pattern) => switch (this) {
    within => _isWithinTimeRange(fieldValue, pattern),
    withinInLast => _isWithinLastDuration(fieldValue, pattern),
    withinInNext => _isWithinNextDuration(fieldValue, pattern),
    without => !_isWithinTimeRange(fieldValue, pattern),
    withoutInLast => !_isWithinLastDuration(fieldValue, pattern),
    withoutInNext => !_isWithinNextDuration(fieldValue, pattern),
  };

  /// 判断是否在指定的持续时间范围内（从当前时间开始）
  bool _isWithinTimeRange(DateTime fieldValue, Duration duration) {
    final now = DateTime.now();
    final endTime = now.add(duration);
    return fieldValue.isAfter(now) && fieldValue.isBefore(endTime);
  }

  /// 判断是否在过去的持续时间范围内
  bool _isWithinLastDuration(DateTime fieldValue, Duration duration) {
    final now = DateTime.now();
    final startTime = now.subtract(duration);
    return fieldValue.isAfter(startTime) && fieldValue.isBefore(now);
  }

  /// 判断是否在未来的持续时间范围内
  bool _isWithinNextDuration(DateTime fieldValue, Duration duration) {
    return _isWithinTimeRange(fieldValue, duration);
  }
}
