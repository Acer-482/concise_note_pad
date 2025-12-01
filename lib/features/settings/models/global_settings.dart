import 'package:concise_note_pad/core/converters/color_data_converter.dart';
import 'package:concise_note_pad/core/enums/font_family_type.dart';
import 'package:concise_note_pad/core/enums/language_type.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_settings.g.dart';

/// 全局设置
@JsonSerializable()
class GlobalSettings extends ChangeNotifier {
  /// 语言
  LanguageType languageType;
  static LanguageType get languageTypeDefault => LanguageType.system;

  /// 主题颜色
  ///
  /// 默认值：青色
  @ColorDataConverter()
  Color themeColor;
  static Color get themeColorDefault => Colors.cyan;

  /// 主题模式
  ///
  /// 默认值：跟随系统
  ThemeMode themeMode;
  static ThemeMode get themeModeDefault => ThemeMode.system;

  /// 主题字体类型
  FontFamilyType fontFamilyType;
  static FontFamilyType get fontFamilyTypeDefault => FontFamilyType.system;

  /// 更新
  void update() {
    notifyListeners();
  }

  /// 设置
  void set(GlobalSettings newSettings) {
    languageType = newSettings.languageType;
    themeColor = newSettings.themeColor;
    themeMode = newSettings.themeMode;
    fontFamilyType = newSettings.fontFamilyType;
  }

  /// 默认构造函数
  GlobalSettings({
    Color? themeColor,
    ThemeMode? themeMode,
    FontFamilyType? fontFamilyType,
    LanguageType? languageType,
  }) : themeColor = themeColor ?? themeColorDefault,
       themeMode = themeMode ?? themeModeDefault,
       fontFamilyType = fontFamilyType ?? fontFamilyTypeDefault,
       languageType = languageType ?? languageTypeDefault;

  factory GlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalSettingsToJson(this);
}
