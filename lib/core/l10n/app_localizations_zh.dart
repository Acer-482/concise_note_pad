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

  @override
  String get moreOptions => '更多选项';

  @override
  String get batchCreationMode => '批量创建模式';

  @override
  String get createText => '新建';

  @override
  String get editText => '编辑';

  @override
  String get mainOptions => '主要选项';

  @override
  String get create => '创建';

  @override
  String get batchCreate => '批量创建';

  @override
  String get save => '保存';

  @override
  String get createComplete => '创建完成';

  @override
  String taskCreateSuccess(String title) {
    return '成功创建了\"$title\"任务项';
  }

  @override
  String get modifyComplete => '修改完成';

  @override
  String taskModifySuccess(String title) {
    return '成功修改了\"$title\"任务项';
  }

  @override
  String get exportFormat => '导出格式化';

  @override
  String get exportFormatDescription => '是否以易读（完整缩进换行）的Json导出';

  @override
  String get exportMode => '导出模式';

  @override
  String get json => 'Json';

  @override
  String get base64 => 'Base64';

  @override
  String get exportAppbarConfig => '导出任务菜单配置文件';

  @override
  String get exportAllTaskItem => '导出所有任务';

  @override
  String get exportToFile => '导出到文件';

  @override
  String get exportToClipboard => '导出到剪贴板';

  @override
  String get clipboard => '剪贴板';

  @override
  String get selectSaveFileLocation => '选择保存文件位置';

  @override
  String get exportSuccess => '导出成功';

  @override
  String exportSuccessMessage(String type, String destination) {
    return '成功导出$type数据到\"$destination\"';
  }

  @override
  String get exportError => '导出发生错误';

  @override
  String get exportCancelled => '导出已取消';

  @override
  String get importWarning =>
      '重要提示\n！导入数据后会完全删除原数据后覆盖！\n！此操作不可逆，且难以恢复！\n！请务必谨慎操作！';

  @override
  String get parseFromFile => '从文件解析';

  @override
  String get parseFromClipboard => '从剪贴板解析';

  @override
  String get overwriteSave => '覆盖保存';

  @override
  String dataInfo(int count, String keys) {
    return '数据信息：\n    数据数量：$count\n    数据列表：$keys';
  }

  @override
  String get parseSuccess => '解析成功';

  @override
  String get readyToOverwrite => '已经准备好覆盖内容';

  @override
  String get parseFailed => '解析失败';

  @override
  String get clipboardDataFailed => '剪贴板数据获取失败';

  @override
  String get checkClipboardAndRetry => '请检查剪贴板或重新复制数据内容';

  @override
  String get parseOverwriteComplete => '解析覆盖完成';

  @override
  String get parseOverwriteFailed => '解析覆盖失败';

  @override
  String get selectDataFile => '选择数据文件';

  @override
  String get defaultTaskTitle => '任务标题';

  @override
  String get defaultTaskSubTitle => '任务小标题';

  @override
  String get defaultTaskDetails =>
      '这里是任务详情，用于描述该任务\n这是一个可完成任务项，拥有：\n\t复选框 —— 用于标记该任务是否完成\n\t重要等级和重要性类型 —— 使用用于标记该任务的重要性和重要程度';

  @override
  String get completableTaskItem => '可完成任务项';

  @override
  String importanceWeight(int weight) {
    return '重要性权重：$weight';
  }

  @override
  String importanceLevelLabel(String level) {
    return '重要程度：$level';
  }

  @override
  String importanceTypeLabel(String type) {
    return '重要性类型：$type';
  }

  @override
  String get completableTaskItemDescription => '创建一个可标记完成、分类和优先级的任务项';

  @override
  String get importanceLevelMinimum => '最低';

  @override
  String get importanceLevelLow => '低';

  @override
  String get importanceLevelMedium => '中';

  @override
  String get importanceLevelHigh => '高';

  @override
  String get importanceLevelCritical => '最高';

  @override
  String get importanceLevel => '重要程度';

  @override
  String get importanceType => '重要性类型';

  @override
  String get isFinished => '是否完成';

  @override
  String get selectTaskType => '选择任务类型';

  @override
  String get newTask => '新建任务';

  @override
  String get title => '标题';

  @override
  String get subTitle => '副标题';

  @override
  String get details => '详细信息';

  @override
  String get isEnabled => '是否启用';

  @override
  String get titleCannotBeEmpty => '标题不可为空';

  @override
  String get titleCannotDuplicate => '标题不可与现有项重复';

  @override
  String get stillInDevelopment => '仍在开发中...';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String titleLabel(String title) {
    return '标题：$title';
  }

  @override
  String subTitleLabel(String subTitle) {
    return '副标题：$subTitle';
  }

  @override
  String createTimeLabel(String dateTime) {
    return '创建时间：$dateTime';
  }

  @override
  String updateTimeLabel(String dateTime) {
    return '最后更改：$dateTime';
  }

  @override
  String get noDetails => '（暂无详细信息）';

  @override
  String taskInfoTitle(String title) {
    return '\"$title\"任务信息';
  }

  @override
  String get editTask => '编辑任务';

  @override
  String get sortMethod => '排序方式：';

  @override
  String get ascending => '升序';

  @override
  String get descending => '降序';

  @override
  String get autoCloseAfterSelection => '选择类型后自动关闭当前页';

  @override
  String get sortByImportance => '按照重要程度排序';

  @override
  String get sortByName => '按照名称排序';

  @override
  String get sortByUpdateDate => '按照最后修改日期排序';

  @override
  String get sortByDate => '按照创建日期排序';

  @override
  String get importanceTypeNotImportantNotUrgent => '不重要不紧急';

  @override
  String get importanceTypeUrgentNotImportant => '紧急不重要';

  @override
  String get importanceTypeImportantNotUrgent => '重要不紧急';

  @override
  String get importanceTypeImportantAndUrgent => '重要且紧急';

  @override
  String get deserializationFailedTypeNull => '反序列化失败：type值为null';

  @override
  String deserializationFailedUnknownType(String type) {
    return '反序列化失败：未知的类型$type';
  }

  @override
  String get basicInformation => '基本信息';

  @override
  String get detailedInformation => '详细信息';

  @override
  String get deleteSuccess => '删除成功';

  @override
  String taskDeleteSuccess(String title) {
    return '成功删除了\"$title\"任务项';
  }
}
