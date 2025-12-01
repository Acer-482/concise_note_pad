import 'dart:convert';
import 'dart:io';

import 'package:concise_note_pad/core/l10n/app_localizations.dart';
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

  // 解析数据
  static Map<String, List<dynamic>> parseData(String data) {
    // 尝试解析为base64 //
    try {
      data = utf8.decode(base64.decoder.convert(data));
    } catch (_) {}
    // 解析json //
    return (jsonDecode(data) as Map<String, dynamic>)
        .cast<String, List<dynamic>>();
  }

  /// 保存数据
  static Future<void> saveData(Map<String, List<dynamic>>? jsonData) async {
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
  }

  @override
  State<StatefulWidget> createState() => _ImportFileOptionMenuState();
}

class _ImportFileOptionMenuState extends State<ImportFileOptionMenu> {
  /// 解析的数据
  Map<String, List<dynamic>>? jsonData;

  /// 构建UI
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            jsonData == null
                ? Text(loc.importWarning, textAlign: TextAlign.center)
                : _buildInfo(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: _selectFile,
                  label: Text(loc.parseFromFile),
                ),
                ElevatedButton.icon(
                  onPressed: _selectClipboard,
                  label: Text(loc.parseFromClipboard),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: jsonData != null ? _trySaveData : null,
              label: Text(
                loc.overwriteSave,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取文件
  Future<void> _selectFile() async {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    FilePickerResult? filePickerResult = await FilePickerUtils.getFile(
      dialogTitle: loc.selectDataFile,
    );
    // 检查是否选中文件 //
    if (filePickerResult != null) {
      PlatformFile platformFile = filePickerResult.files.single;
      Uint8List? bytes = platformFile.bytes;
      _tryParseData(
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    String? clipboardText = (await Clipboard.getData(
      Clipboard.kTextPlain,
    ))?.text;
    if (clipboardText != null) {
      _tryParseData(clipboardText);
    } else {
      if (mounted) {
        ToastUtils.showStandardToast(
          context,
          title: loc.clipboardDataFailed,
          msg: loc.checkClipboardAndRetry,
          type: ToastificationType.warning,
        );
      }
    }
  }

  // 构建显示信息
  Widget _buildInfo() {
    return Text(
      AppLocalizations.of(
        context,
      )!.dataInfo(jsonData!.length, jsonData!.keys.toString()),
    );
  }

  // 尝试解析数据
  Future<void> _tryParseData(String data) async {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    try {
      jsonData = ImportFileOptionMenu.parseData(data);
      setState(() {}); // 更新状态
    } catch (e) {
      if (mounted) {
        ToastUtils.showStandardToast(
          context,
          title: loc.parseFailed,
          msg: '$e',
          type: ToastificationType.error,
        );
      }
    }
  }

  /// 尝试保存数据
  Future<void> _trySaveData() async {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    try {
      ImportFileOptionMenu.saveData(jsonData);
      // 显示完成 //
      ToastUtils.showStandardToast(
        context,
        msg: loc.parseOverwriteComplete,
        type: ToastificationType.success,
      );
    } catch (e) {
      ToastUtils.showStandardToast(
        context,
        title: loc.parseOverwriteFailed,
        msg: '$e',
        type: ToastificationType.error,
      );
    }
  }
}
