import 'dart:convert';

import 'package:concise_note_pad/core/utils/config_helper.dart';
import 'package:concise_note_pad/features/task_filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/settings/models/global_settings.dart';
import 'package:concise_note_pad/core/enums/log_level.dart';
import 'package:concise_note_pad/core/pages/main_page.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 程序入口
///
/// @Acer-482
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 初始化绑定
  TaskFilterRegistry.instance.initAllRegister(); // 初始化过滤器的注册器
  await MainApp.initSettings(); // 初始化设置
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainApp.settings), // 全局设置
        ChangeNotifierProvider(
          create: (context) => TaskManager.instance,
        ), // 任务管理器
      ],
      child: const MainApp(),
    ), // 多状态提供器
  );
}

/// APP入口
///
/// @Acer-482
class MainApp extends StatelessWidget {
  static final GlobalSettings settings = GlobalSettings(); // 全局设置
  static final ConfigHelper _config = ConfigHelper(); // 配置
  const MainApp({super.key});

  /// 初始化设置
  static Future<void> initSettings() async {
    await _config.init('settings.json'); // 初始化配置
    if (!await loadSettings()) {
      await saveSettings(); // 保存默认设置
    }
    settings.addListener(() => saveSettings()); // 更改后保存
  }

  /// 加载设置
  static Future<bool> loadSettings() => _config.load(
    (data) =>
        settings.set(GlobalSettings.fromJson(JsonDecoder().convert(data))),
  );

  /// 保存设置
  static Future<bool> saveSettings() => _config.save(
    () => JsonEncoder.withIndent('\t').convert(settings.toJson()),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalSettings>(
      builder: (context, globalSettings, child) => MaterialApp(
        title: '简记',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: settings.themeColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true, // 启用Material3
        ), // 主题数据
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: settings.themeColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true, // 启用Material3
        ), // 深色主题
        themeMode: settings.themeMode, // 主题模式
        home: const MainPage(),
      ),
    );
  }

  /// 打印日志
  ///
  /// 参数：
  /// - [level] 日志类型
  /// - [v] 日志内容 会调用[Object.toString]
  static void log(LogLevel level, Object v) {
    debugPrint('[${DateTime.now()} | ${level.name}] ${v.toString()}');
  }

  /// 打印信息日志
  static void logInf(Object v) {
    log(LogLevel.info, v);
  }

  /// 打印错误日志
  static void logWar(Object v) {
    log(LogLevel.warning, v);
  }

  /// 打印错误日志
  static void logErr(Object v) {
    log(LogLevel.error, v);
  }
}
