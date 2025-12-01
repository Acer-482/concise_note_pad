import 'package:concise_note_pad/core/enums/font_family_type.dart';
import 'package:concise_note_pad/core/enums/language_type.dart';
import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/settings/global_settings_manager.dart';
import 'package:concise_note_pad/features/settings/models/global_settings.dart';
import 'package:concise_note_pad/core/constants/theme_mode_display_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// 设置选项组
class _SettingsGroup {
  final Function(BuildContext context, AppLocalizations loc) titleBuilder; // 标题
  final List<Widget> Function(
    BuildContext context,
    AppLocalizations loc,
    GlobalSettings settings,
  )
  childrenBuilder; // 子类

  const _SettingsGroup({
    required this.titleBuilder,
    required this.childrenBuilder,
  });

  List<Widget> buildToList(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return <Widget>[
          Text(
            titleBuilder(context, loc),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ] +
        childrenBuilder(context, loc, GlobalSettingsManager.instance.settings) +
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
  // 构建选项组列表
  List<_SettingsGroup> _buildSettingsGroupList(BuildContext context) {
    final List<_SettingsGroup> settingsGroupList = [];
    settingsGroupList.add(_buildGlobalSettings(context));
    settingsGroupList.add(_buildTheme(context));
    return settingsGroupList;
  }

  // 构建全局选项组
  _SettingsGroup _buildGlobalSettings(BuildContext context) {
    return _SettingsGroup(
      titleBuilder: (context, loc) => loc.settingsGroupGlobal,
      childrenBuilder: (context, loc, settings) => [
        ListTile(
          leading: Icon(Icons.replay_outlined),
          title: Text(loc.resetAllSettings),
          trailing: TextButton(
            onPressed: () => PageUtils.showConfirmDialog(
              context,
              completedMessage: loc.resetSuccess,
              confirmFunc: () {
                settings.set(GlobalSettings());
                settings.update(); // 更新
              }, // 重置设置
            ),
            child: Text(loc.reset, style: TextStyle(color: Colors.red)),
          ),
        ), // 重置设置
        ListTile(
          leading: Icon(Icons.replay_outlined),
          title: Text(loc.language),
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

  // 构建主题选项组
  _SettingsGroup _buildTheme(BuildContext context) {
    return _SettingsGroup(
      titleBuilder: (context, loc) => loc.settingsGroupTheme,
      childrenBuilder: (context, loc, settings) => [
        ListTile(
          leading: Icon(Icons.light_mode),
          title: Text(loc.themeMode),
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
          title: Text(loc.themeColor),
          trailing: TextButton(
            onPressed: _showColorPicker,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.colorize_rounded, color: settings.themeColor),
                Text(loc.pickColor),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.color_lens_rounded),
          title: Text(loc.themeColor),
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Scaffold(
      appBar: AppBar(title: Text(loc.settingsPageTitle)), // 标题
      body: _buildBody(context),
    );
  }

  /// 构建主体
  Widget _buildBody(BuildContext context) {
    // 构建设置列表 //
    List<Widget> settingWidgetList = [];
    for (var settingsGroup in _buildSettingsGroupList(context)) {
      settingWidgetList.addAll(settingsGroup.buildToList(context));
    }
    return Column(spacing: 4, children: settingWidgetList); // 构建返回
  }

  /// 显示颜色选择器
  Future<T?> _showColorPicker<T>() {
    Color currentColor = GlobalSettingsManager.instance.settings.themeColor;
    return showDialog<T>(
      context: context,
      builder: (context) {
        final loc = AppLocalizations.of(context)!; // 获取本地化
        return AlertDialog(
          title: Text(loc.selectThemeColor),
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
              child: Text(loc.confirm),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.cancel),
            ),
          ],
        );
      },
    );
  }
}
