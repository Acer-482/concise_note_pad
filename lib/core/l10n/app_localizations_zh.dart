// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '简记';

  @override
  String get languageType_system => '跟随系统';

  @override
  String get languageType_en => 'English';

  @override
  String get languageType_zh => '简体中文';

  @override
  String get themeModeDisplayName_system => '跟随系统';

  @override
  String get themeModeDisplayName_light => '亮色';

  @override
  String get themeModeDisplayName_dark => '暗色';

  @override
  String get fontFamilyType_system => '系统默认';

  @override
  String get fontFamilyType_alibabaPuHuiTi => '阿里巴巴普惠体';

  @override
  String get settingsPageTitle => '设置';

  @override
  String get settingsGroupGlobal => '全局设置';

  @override
  String get resetAllSettings => '重置所有设置';

  @override
  String get reset => '重置';

  @override
  String get language => '语言';

  @override
  String get settingsGroupTheme => '主题';

  @override
  String get themeMode => '主题模式';

  @override
  String get themeColor => '主题颜色';

  @override
  String get pickColor => '选取颜色';

  @override
  String get themeFont => '主题字体';

  @override
  String get selectThemeColor => '选择主题色';

  @override
  String get confirmDialogDefaultTitle => '确认？';

  @override
  String confirmDialogMessage(String text) {
    return '你确认$text吗？';
  }

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确定';

  @override
  String get confirmDialogTitle => '确认？';

  @override
  String get confirmDialogDefaultMessage => '此操作无法恢复！';

  @override
  String get success => '操作成功';

  @override
  String get resetSuccess => '重置成功';

  @override
  String get navigationHome => '主页面';

  @override
  String get navigationTasks => '任务';

  @override
  String get drawerTitle => '侧边栏';

  @override
  String get drawerSettings => '设置';

  @override
  String get drawerAbout => '关于';

  @override
  String get aboutPageTitle => '关于';

  @override
  String get more => '更多';

  @override
  String get moreLicenseInfo => '更多许可证信息';

  @override
  String get goToGithubRepo => '跳转到github仓库';

  @override
  String get githubRepoUrl => 'https://github.com/Acer-482/concise_note_pad';

  @override
  String versionWithParam(String version) {
    return '版本 $version';
  }

  @override
  String get softwareLicense => '本软件采用 GPL-3.0 许可证';

  @override
  String get copyright => '版权所有 © 2025 Acer';

  @override
  String get failedToGetAppInfo => '获取应用信息失败';

  @override
  String get jumpFailed => '跳转失败';

  @override
  String jumpToUriFailed(String uri) {
    return '跳转到\"$uri\"失败';
  }

  @override
  String jumpToUriError(String uri, String error) {
    return '跳转到\"$uri\"时发生错误：$error';
  }
}
