import 'package:concise_note_pad/page/main_page.dart';
import 'package:concise_note_pad/task_item/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 日志等级
enum LogLevel {
  info,
  warning,

  error;

  String get name => switch (this) {
    info => 'INFO',
    warning => 'WARNING',
    error => 'ERROR',
  };
}

/// 程序入口
void main() {
  runApp(const MainApp());
}

/// APP入口
///
/// @Acer-482
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '简记',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ), // 主题数据
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskManager.instance),
        ],
        child: const MainPage(),
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
