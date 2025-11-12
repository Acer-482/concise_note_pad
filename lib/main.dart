import 'package:concise_note_pad/home_page.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 程序入口
void main() {
  runApp(const MainApp());
}

/// APP入口
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
        child: const HomePage(),
      ),
    );
  }

  /// 打印日志
  static void log(String type, Object v) {
    debugPrint('[${DateTime.now()} | $type] ${v.toString()}');
  }

  /// 打印信息日志
  static void logInf(Object v) {
    log('INFO', v);
  }

  // 打印错误日志
  static void logWar(Object v) {
    log('WARNING', v);
  }

  // 打印错误日志
  static void logErr(Object v) {
    log('ERROR', v);
  }
}
