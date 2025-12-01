import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// 字体类型枚举
enum FontFamilyType {
  system,
  alibabaPuHuiTi;

  /// 显示名称
  String displayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return switch (this) {
      system => loc.fontFamilyType_system,
      alibabaPuHuiTi => loc.fontFamilyType_alibabaPuHuiTi,
    };
  }

  /// 获取父字体
  String? get fontFamily => switch (this) {
    system => null,
    alibabaPuHuiTi => 'AlibabaPuHuiTi',
  };
}
