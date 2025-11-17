import 'package:concise_note_pad/global_settings.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/theme_mode_display_name.dart';
import 'package:concise_note_pad/util/page_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  /// 显示确认对话框
  Future<T?> _showConfirmDialog<T>(
    String text,
    void Function(BuildContext context) exec,
  ) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认？'),
        content: Text('你确认$text吗？'),
        actions: [
          TextButton(
            onPressed: () {
              exec(context);
              Navigator.pop(context);
            },
            child: Text('确定'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
        ],
      ),
    );
  }

  /// 显示颜色选择器
  Future<T?> _showColorPicker<T>() {
    Color currentColor = MainApp.settings.themeColor;
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('选择主题色'),
        content: Column(
          children: [
            Expanded(
              child: ColorPicker(
                pickerColor: currentColor,
                enableAlpha: false, // 禁用alpha
                // hexInputBar: true, // 十六进制输入框
                onColorChanged: (v) {
                  currentColor = v;
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              MainApp.settings.themeColor = currentColor; // 设置为当前颜色
              MainApp.settings.update(); // 更新
              Navigator.pop(context);
            },
            child: Text('确定'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = MainApp.settings;
    return Scaffold(
      appBar: PageUtils.buildDefaultAppbar(context, Text('设置')),
      body: Column(
        children: [
          PageUtils.buildDefaultTitleFrame(
            context: context,
            title: '全局设置',
            childWidget: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.replay_outlined),
                  title: Text('重置所有设置'),
                  trailing: TextButton(
                    onPressed: () => _showConfirmDialog(
                      '重置所有设置',
                      (context) {
                        settings.set(GlobalSettings());
                        settings.update(); // 更新
                      }, // 重置设置
                    ),
                    child: Text('重置', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
          PageUtils.buildDefaultTitleFrame(
            context: context,
            title: '主题',
            childWidget: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.light_mode),
                  title: Text('主题'),
                  trailing: DropdownButton(
                    value: settings.themeMode,
                    items: ThemeMode.values
                        .map(
                          (mode) => DropdownMenuItem(
                            value: mode,
                            child: Text(mode.displayName),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      settings.themeMode = value!;
                      settings.update();
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.color_lens_rounded),
                  title: Text('主题颜色'),
                  trailing: TextButton(
                    onPressed: _showColorPicker,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.colorize_rounded,
                          color: settings.themeColor,
                        ),
                        Text('选取颜色'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
