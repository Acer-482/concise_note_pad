import 'dart:convert';

import 'package:concise_note_pad/core/utils/file_picker_utils.dart';
import 'package:concise_note_pad/core/utils/toast_utils.dart';
import 'package:concise_note_pad/features/tasks/task_menu/task_menu_manager.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

/// 导出文件设置菜单
class ExportFileOptionMenu extends StatefulWidget {
  const ExportFileOptionMenu({super.key});

  @override
  State<StatefulWidget> createState() => _ExportFileOptionMenuState();
}

class _ExportFileOptionMenuState extends State<ExportFileOptionMenu> {
  bool exportAppbarConfig = false; // 导出菜单配置文件
  bool exportAllTaskItem = false; // 导出所有任务
  bool exportFormat = true; // 导出格式化
  bool exportB64 = true; // 导出Base64 如果为false，则导出Json

  @override
  Widget build(BuildContext context) {
    bool canExport = exportAppbarConfig || exportAllTaskItem;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            SwitchListTile(
              value: exportFormat,
              onChanged: (v) => setState(() => exportFormat = v),
              title: Text('导出格式化'),
              subtitle: Text('是否以易读（完整缩进换行）的Json导出'),
            ),
            ListTile(
              title: const Text('导出模式'),
              trailing: SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: false,
                    icon: Icon(Icons.abc),
                    label: Text('Json'),
                  ),
                  ButtonSegment(
                    value: true,
                    icon: Icon(Icons.numbers_rounded),
                    label: Text('Base64'),
                  ),
                ],
                selected: {exportB64},
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() => exportB64 = newSelection.first);
                },
                showSelectedIcon: false,
              ),
            ),
            Divider(),
            SwitchListTile(
              value: exportAppbarConfig,
              onChanged: (v) => setState(() => exportAppbarConfig = v),
              title: Text('导出任务菜单配置文件'),
            ),
            SwitchListTile(
              value: exportAllTaskItem,
              onChanged: (v) => setState(() => exportAllTaskItem = v),
              title: Text('导出所有任务'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                ElevatedButton.icon(
                  onPressed: canExport ? () => _export(false) : null,
                  icon: const Icon(Icons.save),
                  label: const Text('导出到文件'),
                ),
                ElevatedButton.icon(
                  onPressed: canExport ? () => _export(true) : null,
                  icon: const Icon(Icons.copy),
                  label: const Text('导出到剪贴板'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 导出数据
  String _exportJsonString() {
    JsonEncoder encoder = exportFormat
        ? JsonEncoder.withIndent('\t')
        : JsonEncoder(); // Json编码器
    Map<String, dynamic> map = {}; // 数据map
    // 任务菜单配置文件
    if (exportAppbarConfig) {
      map['AppbarConfig'] = TaskMenuManager.instance.toJson();
    }
    // 所有任务
    if (exportAllTaskItem) {
      map['TaskItem'] = TaskManager.instance.toJson();
    }
    return encoder.convert(map);
  }

  /// 导出到 - 文件 / 剪贴板
  Future<void> _export(bool toClipboard) async {
    String? ret;
    bool hasError = false; // 发生错误
    try {
      String saveJson = _exportJsonString(); // 获取导出的json
      // 为base64模式则再次加密 //
      if (exportB64) {
        saveJson = base64.encode(utf8.encode(saveJson));
      }
      // 保存 //
      if (toClipboard) {
        await _saveToClipboard(saveJson);
        ret = '剪贴板';
      } else {
        ret = await FilePickerUtils.saveFile(
          dialogTitle: '选择保存文件位置',
          fileName: exportB64 ? 'config.txt' : 'config.json',
          data: saveJson,
        );
      }
    } catch (e) {
      hasError = true;
      ret = e.toString();
    }
    // 输出结果 //
    if (ret != null) {
      _showFinishToast(
        title: '导出成功',
        msg: '成功导出${exportB64 ? 'Base64' : 'Json'}数据到"$ret"',
        type: ToastificationType.success,
      );
    } else if (hasError) {
      _showFinishToast(
        title: '导出发生错误',
        msg: ret!,
        type: ToastificationType.error,
      );
    } else {
      _showFinishToast(msg: '导出已取消', type: ToastificationType.info);
    }
  }

  /// 显示导出成功提示
  void _showFinishToast({
    String? title,
    required String msg,
    required ToastificationType type,
  }) {
    ToastUtils.showStandardToast(context, title: title, msg: msg, type: type);
  }

  /// 拷贝到剪贴板
  Future<void> _saveToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
