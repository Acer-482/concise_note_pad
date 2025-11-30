/// 字体类型枚举
enum FontFamilyType {
  system,
  alibabaPuHuiTi;

  /// 显示名称
  String get displayName => switch (this) {
    system => '系统默认',
    alibabaPuHuiTi => '阿里巴巴普惠体',
  };

  /// 获取父字体
  String? get fontFamily => switch (this) {
    system => null,
    alibabaPuHuiTi => 'AlibabaPuHuiTi',
  };
}
