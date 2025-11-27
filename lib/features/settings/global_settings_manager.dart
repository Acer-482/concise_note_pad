import 'dart:convert';

import 'package:concise_note_pad/core/utils/config_helper.dart';
import 'package:concise_note_pad/features/settings/models/global_settings.dart';

/// 全局设置管理器 - 单例模式类
class GlobalSettingsManager {
  // 静态常量 //
  static const String configName = 'task_menu_configs.json';
  // 单例 //
  static final GlobalSettingsManager _instance =
      GlobalSettingsManager._internal();
  static GlobalSettingsManager get instance => _instance; // 获取单例类
  /// 单例构造
  GlobalSettingsManager._internal();

  final GlobalSettings settings = GlobalSettings(); // 全局设置
  final ConfigHelper _config = ConfigHelper(); // 全局配置

  /// 初始化
  ///
  /// 必须由外部手动调用
  ///
  /// 将尝试从文件加载配置，加载失败时使用默认值
  Future<void> init() async {
    await _config.init('settings.json'); // 初始化配置
    if (!await loadSettings()) {
      await saveSettings(); // 保存默认设置
    }
    settings.addListener(() => saveSettings()); // 更改后保存
  }

  /// 加载设置
  Future<bool> loadSettings() => _config.load(
    (data) =>
        settings.set(GlobalSettings.fromJson(JsonDecoder().convert(data))),
  );

  /// 保存设置
  Future<bool> saveSettings() => _config.save(
    () => JsonEncoder.withIndent('\t').convert(settings.toJson()),
  );
}
