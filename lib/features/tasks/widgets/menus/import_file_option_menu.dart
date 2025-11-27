import 'dart:convert';
import 'dart:io';

import 'package:concise_note_pad/core/utils/file_picker_utils.dart';
import 'package:concise_note_pad/core/utils/toast_utils.dart';
import 'package:concise_note_pad/features/task_menus/task_menu_manager.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

/// 导入文件设置菜单
class ImportFileOptionMenu extends StatefulWidget {
  const ImportFileOptionMenu({super.key});

  @override
  State<StatefulWidget> createState() => _ImportFileOptionMenuState();
}

class _ImportFileOptionMenuState extends State<ImportFileOptionMenu> {
  Map<String, List<dynamic>>? jsonData; // 解析的数据
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            jsonData == null
                ? const Text(
                    '重要提示\n！导入数据后会完全删除原数据后覆盖！\n！此操作不可逆，且难以恢复！\n！请务必谨慎操作！',
                    textAlign: TextAlign.center,
                  )
                : _buildInfo(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: _selectFile,
                  label: const Text('从文件解析'),
                ),
                ElevatedButton.icon(
                  onPressed: _selectClipboard,
                  label: const Text('从剪贴板解析'),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: jsonData != null ? _saveData : null,
              label: const Text('覆盖保存', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取文件
  Future<void> _selectFile() async {
    FilePickerResult? filePickerResult = await FilePickerUtils.getFile(
      dialogTitle: '选择数据文件',
    );
    // 检查是否选中文件 //
    if (filePickerResult != null) {
      PlatformFile platformFile = filePickerResult.files.single;
      Uint8List? bytes = platformFile.bytes;
      _parseData(
        bytes != null
            ? utf8.decode(bytes)
            : (await File(
                platformFile.path!,
              ).readAsString()).toString(), // 无法读取内容则直接通过File类读取
      );
    }
  }

  /// 获取剪贴板
  Future<void> _selectClipboard() async {
    String? clipboardText = (await Clipboard.getData(
      Clipboard.kTextPlain,
    ))?.text;
    if (clipboardText != null) {
      _parseData(clipboardText);
    } else {
      if (mounted) {
        ToastUtils.showStandardToast(
          context,
          title: '剪贴板数据获取失败',
          msg: '请检查剪贴板或重新复制数据内容',
          type: ToastificationType.warning,
        );
      }
    }
  }

  // 构建显示信息
  Widget _buildInfo() {
    return Text('''数据信息：
    数据数量：${jsonData!.length}
    数据列表：${jsonData!.keys}
    ''');
  }

  // 解析数据
  Future<void> _parseData(String data) async {
    try {
      // 尝试解析为base64 //
      try {
        data = utf8.decode(base64.decoder.convert(data));
      } catch (_) {}
      // 解析json //
      jsonData = (jsonDecode(data) as Map<String, dynamic>)
          .cast<String, List<dynamic>>();
      if (mounted) {
        (ToastUtils.showStandardToast(
          context,
          title: '解析成功',
          msg: '已经准备好覆盖内容',
          type: ToastificationType.success,
        ));
      }
      setState(() {}); // 更新状态
    } catch (e) {
      if (mounted) {
        ToastUtils.showStandardToast(
          context,
          title: '解析失败',
          msg: '$e',
          type: ToastificationType.error,
        );
      }
    }
  }

  /// 保存数据
  Future<void> _saveData() async {
    try {
      final json = jsonData!;
      // 解析覆盖数据 //
      if (json.containsKey('AppbarConfig')) {
        TaskMenuManager.instance.setFromJsonList(json['AppbarConfig']!);
        TaskMenuManager.instance.save(); // 保存
      }
      if (json.containsKey('TaskItem')) {
        TaskManager.instance.setFromJsonList(json['TaskItem']!);
      }
      // 更新任务管理器 //
      TaskManager.instance.update();
      // 显示完成 //
      ToastUtils.showStandardToast(
        context,
        msg: '解析覆盖完成',
        type: ToastificationType.success,
      );
    } catch (e) {
      ToastUtils.showStandardToast(
        context,
        title: '解析覆盖失败',
        msg: '$e',
        type: ToastificationType.error,
      );
    }
  }
}
