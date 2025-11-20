/// 字段匹配模式混合
mixin MatchModeMixin<T, S> {
  String get displayName; // 显示名称

  /// 匹配模板
  ///
  /// 当返回值为true时 则匹配
  bool matchesPattern(T fieldText, S pattern);
}
