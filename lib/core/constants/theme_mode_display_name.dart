import 'package:flutter/material.dart';

/// 主题模式显示名称
extension ThemeModeDisplayName on ThemeMode {
  String get displayName => switch (this) {
    ThemeMode.system => '跟随系统',
    ThemeMode.light => '亮色',
    ThemeMode.dark => '暗色',
  };
}
