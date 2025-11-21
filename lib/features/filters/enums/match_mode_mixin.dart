/// 字段匹配模式混合
mixin MatchModeMixin<T, S> {
  /// 显示名称
  String get displayName;

  /// 获取所有枚举值
  List<MatchModeMixin> get mixinValues;

  /// 匹配模板
  ///
  /// 当返回值为true时 则匹配
  bool matchesPattern(T fieldText, S pattern);
}
