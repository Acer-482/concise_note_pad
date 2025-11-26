import 'package:concise_note_pad/features/task_filters/enums/match_mode_mixin.dart';
import 'package:flutter/material.dart';

/// 时间字段匹配模式
enum DateTimeMatchMode with MatchModeMixin<DateTime, DateTime> {
  exactYear,
  exactMonth,
  exactDay,
  exact,
  before,
  after;

  @override
  String get displayName => switch (this) {
    exactYear => '精确时间（年）',
    exactMonth => '精确时间（月）',
    exactDay => '精确时间（日）',
    exact => '绝对精确时间',
    before => '字段值在匹配模板之前',
    after => '字段值在匹配模板之后',
  };

  @override
  List<MatchModeMixin> get mixinValues => values;

  @override
  bool matchesPattern(fieldValue, pattern) => switch (this) {
    DateTimeMatchMode.exactYear => fieldValue.year == pattern.year,
    DateTimeMatchMode.exactMonth => DateUtils.isSameMonth(fieldValue, pattern),
    DateTimeMatchMode.exactDay => DateUtils.isSameDay(fieldValue, pattern),
    DateTimeMatchMode.exact => fieldValue.isAtSameMomentAs(pattern),
    DateTimeMatchMode.before => fieldValue.isBefore(pattern),
    DateTimeMatchMode.after => fieldValue.isAfter(pattern),
  };
}
