import 'package:concise_note_pad/core/enums/font_family_type.dart';
import 'package:concise_note_pad/core/enums/language_type.dart';
import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/features/settings/global_settings_manager.dart';
import 'package:concise_note_pad/features/settings/models/global_settings.dart';
import 'package:concise_note_pad/core/constants/theme_mode_display_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// 设置选项组
class _SettingsGroup {
  final String title; // 标题
  final List<Widget> Function(
    BuildContext context,
    AppLocalizations loc,
    GlobalSettings settings,
  )
  childrenBuilder; // 子类

  const _SettingsGroup({required this.title, required this.childrenBuilder});

  List<Widget> buildToList(BuildContext context) {
    return <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleLarge),
        ] +
        childrenBuilder(
          context,
          AppLocalizations.of(context)!,
          GlobalSettingsManager.instance.settings,
        ) +
        [Divider()];
  }
}

/// 设置页面
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<_SettingsGroup> _settingsGroupList = [];

  @override
  void initState() {
    super.initState();
    _settingsGroupList.add(_buildGlobalSettings());
    _settingsGroupList.add(_buildTheme());
  }

  _SettingsGroup _buildGlobalSettings() {
    return _SettingsGroup(
      title: '全局设置',
      childrenBuilder: (context, loc, settings) => [
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
        ), // 重置设置
        ListTile(
          leading: Icon(Icons.replay_outlined),
          title: Text('语言'),
          trailing: DropdownButton(
            value: settings.languageType,
            items: LanguageType.values
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.displayName(context)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() {
              settings.languageType = v!;
              settings.update();
            }),
          ),
        ), // 语言
      ],
    );
  }

  _SettingsGroup _buildTheme() {
    return _SettingsGroup(
      title: '主题',
      childrenBuilder: (context, loc, settings) => [
        ListTile(
          leading: Icon(Icons.light_mode),
          title: Text('主题模式'),
          trailing: DropdownButton(
            value: settings.themeMode,
            items: ThemeMode.values
                .map(
                  (mode) => DropdownMenuItem(
                    value: mode,
                    child: Text(mode.displayName(context)),
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
                    child: Text(mode.displayName(context)),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() {
              settings.fontFamilyType = value!;
              settings.update();
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: _buildBody(context),
    );
  }

  /// 构建主体
  Widget _buildBody(BuildContext context) {
    // 构建设置列表 //
    List<Widget> settingWidgetList = [];
    for (var settingsGroup in _settingsGroupList) {
      settingWidgetList.addAll(settingsGroup.buildToList(context));
    }
    return Column(spacing: 4, children: settingWidgetList); // 构建返回
  }

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
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            enableAlpha: false, // 禁用alpha
            hexInputBar: true, // 十六进制输入框
            onColorChanged: (v) {
              currentColor = v;
            },
          ),
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
}
