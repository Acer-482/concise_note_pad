import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 配置工具类
/// 
/// 目前提供配置文件的实用方法
class ConfigUtils {
  /// 获取默认文件存放目录
  static Future<Directory> getDefaultFileDirectory() {
    if (Platform.isAndroid || Platform.isIOS) {
      return getApplicationDocumentsDirectory(); // 移动端
    } else {
      return getApplicationSupportDirectory(); // 桌面端
    }
  }

  /// 获取配置文件存放文件
  static Future<File> getConfig(String configName) async {
    return File('${(await getDefaultFileDirectory()).path}/$configName');
  }
}
