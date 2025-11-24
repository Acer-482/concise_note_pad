import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

/// 文件选择器工具类
class FilePickerUtils {
  /// 保存文件
  static Future<String?> saveFile({
    String? dialogTitle,
    String? fileName,
    String? initialDirectory,
    bool lockParentWindow = true,
    Uint8List? bytes,
    String? data,
  }) async {
    assert(
      (bytes == null && data != null) ||
          (bytes != null && data == null) ||
          (bytes != null && data != null),
    );
    return await FilePicker.platform.saveFile(
      dialogTitle: dialogTitle,
      fileName: fileName,
      initialDirectory: initialDirectory,
      lockParentWindow: lockParentWindow,
      bytes: bytes ?? Uint8List.fromList(utf8.encode(data!)),
    );
  }
}
