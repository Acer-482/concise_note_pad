import 'dart:io';

import 'package:concise_note_pad/main.dart';
import 'package:path_provider/path_provider.dart';

/// 配置工具类
///
/// 目前提供配置文件的实用方法
class ConfigHelper {
  /// 获取默认文件存放目录
  static Future<Directory> getDefaultFileDirectory() {
    if (Platform.isAndroid || Platform.isIOS) {
      return getApplicationDocumentsDirectory(); // 移动端
    } else {
      return getApplicationSupportDirectory(); // 桌面端
    }
  }

  late final String configFileName; // 配置文件名称
  late final File file; // 配置文件
  bool _isReady = false; // 准备就绪

  ConfigHelper();

  /// 初始化
  Future<bool> init(String configFileName) async {
    if (_isReady) throw Exception('init不能重复调用');
    try {
      MainApp.logInf('初始化配置文件("$configFileName")中...');
      this.configFileName = configFileName; // 设置配置文件名称
      file = File(
        '${(await getDefaultFileDirectory()).path}/$configFileName',
      ); // 获取文件
      _isReady = true; // 标记 准备就绪
      MainApp.logInf('初始化配置文件("$configFileName")成功');
      return true;
    } catch (e) {
      MainApp.logWar('初始化配置文件("$configFileName")失败：$e');
      return false;
    }
  }

  /// 保存
  ///
  /// 当加载失败时，返回false
  Future<bool> save(String Function() buildData) async {
    if (!_isReady) throw Exception('请先调用init');
    try {
      MainApp.logInf('保存$configFileName配置("${file.path}")中...');
      file.writeAsString(buildData());
      MainApp.logInf('保存$configFileName配置("${file.path}")成功');
      return true;
    } catch (e) {
      MainApp.logWar('保存$configFileName配置("${file.path}")失败：$e');
      return false;
    }
  }

  /// 加载
  ///
  /// 当加载失败时，返回false
  Future<bool> load(void Function(String data) loadFunc) async {
    if (!_isReady) throw Exception('请先调用init');
    try {
      MainApp.logInf('加载"$configFileName"配置("${file.path}")中...');
      loadFunc(await file.readAsString());
      MainApp.logInf('加载"$configFileName"配置成功');
      return true;
    } catch (e) {
      MainApp.logWar('加载$configFileName配置("${file.path}")失败：$e');
      return false;
    }
  }
}
