/// 布尔字段匹配模式
enum BooleanMatchMode {
  exact,
  and,
  or,
  not,
  xor;

  String get displayName => switch (this) {
    exact => '精确',
    and => '与逻辑',
    or => '或逻辑',
    not => '非逻辑',
    xor => '异或逻辑',
  };
}
