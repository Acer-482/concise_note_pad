import 'package:concise_note_pad/core/converters/color_data_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_settings.g.dart';

/// 全局设置
@JsonSerializable()
class GlobalSettings extends ChangeNotifier {
  /// 主题颜色
  ///
  /// 默认值：青色
  @ColorDataConverter()
  Color themeColor;
  static const Color themeColorDefault = Colors.cyan;

  /// 主题模式
  ///
  /// 默认值：跟随系统
  ThemeMode themeMode;
  static const ThemeMode themeModeDefault = ThemeMode.system;

  /// 更新
  void update() {
    notifyListeners();
  }

  /// 设置
  void set(GlobalSettings newSettings) {
    themeColor = newSettings.themeColor;
    themeMode = newSettings.themeMode;
  }

  /// 默认构造函数
  GlobalSettings({
    this.themeColor = themeColorDefault,
    this.themeMode = themeModeDefault,
  });

  factory GlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalSettingsToJson(this);
}
