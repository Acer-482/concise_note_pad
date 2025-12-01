import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// 语言类型
///
/// 用于存储程序支持的国际化语言类型
enum LanguageType {
  system,
  en,
  zhCN,
  zhTW;

  /// 语言代码
  String? get code => switch (this) {
    system => null,
    en => 'en',
    zhCN => 'zh',
    zhTW => 'zh_TW',
  };

  /// 显示名称
  String displayName(BuildContext context) => switch (this) {
    system => AppLocalizations.of(context)!.languageType_system,
    en => 'English',
    zhCN => '简体中文',
    zhTW => '繁體中文',
  };
}
