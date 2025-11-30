import 'package:concise_note_pad/core/enums/font_family_type.dart';
import 'package:concise_note_pad/features/settings/global_settings_manager.dart';
import 'package:concise_note_pad/features/settings/models/global_settings.dart';
import 'package:concise_note_pad/core/constants/theme_mode_display_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// 设置页面
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
    Color currentColor = GlobalSettingsManager.instance.settings.themeColor;
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('选择主题色'),
        content: ListView(
          children: [
            ColorPicker(
              pickerColor: currentColor,
              enableAlpha: false, // 禁用alpha
              hexInputBar: true, // 十六进制输入框
              onColorChanged: (v) {
                currentColor = v;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              GlobalSettingsManager.instance.settings.themeColor =
                  currentColor; // 设置为当前颜色
              GlobalSettingsManager.instance.settings.update(); // 更新
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
    final settings = GlobalSettingsManager.instance.settings;
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: Column(
        children: [
          Text('全局设置', style: Theme.of(context).textTheme.titleLarge),
          Column(
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
          Divider(),
          Text('主题', style: Theme.of(context).textTheme.titleLarge),
          ListTile(
            leading: Icon(Icons.light_mode),
            title: Text('主题模式'),
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
              onChanged: (value) => setState(() {
                settings.themeMode = value!;
                settings.update();
              }),
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
                  Icon(Icons.colorize_rounded, color: settings.themeColor),
                  Text('选取颜色'),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.color_lens_rounded),
            title: Text('主题字体'),
            trailing: DropdownButton(
              value: settings.fontFamilyType,
              items: FontFamilyType.values
                  .map(
                    (mode) => DropdownMenuItem(
                      value: mode,
                      child: Text(mode.displayName),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() {
                settings.fontFamilyType = value!;
                settings.update();
              }),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
