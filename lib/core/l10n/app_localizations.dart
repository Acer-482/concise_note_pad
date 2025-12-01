import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// 应用程序的名称
  ///
  /// In zh, this message translates to:
  /// **'简记'**
  String get appName;

  /// 语言类型枚举：跟随系统设置
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get languageType_system;

  /// 主题模式：跟随系统设置
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get themeModeDisplayName_system;

  /// 主题模式：亮色主题
  ///
  /// In zh, this message translates to:
  /// **'亮色'**
  String get themeModeDisplayName_light;

  /// 主题模式：暗色主题
  ///
  /// In zh, this message translates to:
  /// **'暗色'**
  String get themeModeDisplayName_dark;

  /// 字体类型枚举：系统默认字体
  ///
  /// In zh, this message translates to:
  /// **'系统默认'**
  String get fontFamilyType_system;

  /// 字体类型枚举：阿里巴巴普惠体
  ///
  /// In zh, this message translates to:
  /// **'阿里巴巴普惠体'**
  String get fontFamilyType_alibabaPuHuiTi;

  /// 设置页面的标题
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settingsPageTitle;

  /// 全局设置组的标题
  ///
  /// In zh, this message translates to:
  /// **'全局设置'**
  String get settingsGroupGlobal;

  /// 重置所有设置的列表项标题
  ///
  /// In zh, this message translates to:
  /// **'重置所有设置'**
  String get resetAllSettings;

  /// 重置操作的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'重置'**
  String get reset;

  /// 语言设置的列表项标题
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get language;

  /// 主题设置组的标题
  ///
  /// In zh, this message translates to:
  /// **'主题'**
  String get settingsGroupTheme;

  /// 主题模式的列表项标题
  ///
  /// In zh, this message translates to:
  /// **'主题模式'**
  String get themeMode;

  /// 主题颜色的列表项标题
  ///
  /// In zh, this message translates to:
  /// **'主题颜色'**
  String get themeColor;

  /// 选择颜色的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'选取颜色'**
  String get pickColor;

  /// 主题字体的列表项标题
  ///
  /// In zh, this message translates to:
  /// **'主题字体'**
  String get themeFont;

  /// 颜色选择对话框的标题
  ///
  /// In zh, this message translates to:
  /// **'选择主题色'**
  String get selectThemeColor;

  /// 确认对话框的默认标题
  ///
  /// In zh, this message translates to:
  /// **'确认？'**
  String get confirmDialogDefaultTitle;

  /// 确认对话框的消息内容，带参数
  ///
  /// In zh, this message translates to:
  /// **'你确认{text}吗？'**
  String confirmDialogMessage(String text);

  /// 通用取消按钮文本
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// 通用确认按钮文本
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get confirm;

  /// 确认对话框的标题
  ///
  /// In zh, this message translates to:
  /// **'确认？'**
  String get confirmDialogTitle;

  /// 确认对话框的默认消息内容
  ///
  /// In zh, this message translates to:
  /// **'此操作无法恢复！'**
  String get confirmDialogDefaultMessage;

  /// 操作成功后的提示消息
  ///
  /// In zh, this message translates to:
  /// **'操作成功'**
  String get success;

  /// 重置操作成功后的提示消息
  ///
  /// In zh, this message translates to:
  /// **'重置成功'**
  String get resetSuccess;

  /// 主页面导航项标签
  ///
  /// In zh, this message translates to:
  /// **'主页面'**
  String get navigationHome;

  /// 任务页面导航项标签
  ///
  /// In zh, this message translates to:
  /// **'任务'**
  String get navigationTasks;

  /// 抽屉菜单的标题
  ///
  /// In zh, this message translates to:
  /// **'侧边栏'**
  String get drawerTitle;

  /// 抽屉菜单中的设置项
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get drawerSettings;

  /// 抽屉菜单中的关于项
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get drawerAbout;

  /// 关于页面：标题
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get aboutPageTitle;

  /// 关于页面中'更多'部分的标题
  ///
  /// In zh, this message translates to:
  /// **'更多'**
  String get more;

  /// 查看更多许可证信息的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'更多许可证信息'**
  String get moreLicenseInfo;

  /// 跳转到GitHub仓库的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'跳转到github仓库'**
  String get goToGithubRepo;

  /// GitHub仓库URL，显示在关于页面
  ///
  /// In zh, this message translates to:
  /// **'https://github.com/Acer-482/concise_note_pad'**
  String get githubRepoUrl;

  /// 版本号的前缀文本，带版本号参数
  ///
  /// In zh, this message translates to:
  /// **'版本 {version}'**
  String versionWithParam(String version);

  /// 软件许可证声明
  ///
  /// In zh, this message translates to:
  /// **'本软件采用 GPL-3.0 许可证'**
  String get softwareLicense;

  /// 版权声明
  ///
  /// In zh, this message translates to:
  /// **'版权所有 © 2025 Acer'**
  String get copyright;

  /// 获取包信息失败时的错误提示
  ///
  /// In zh, this message translates to:
  /// **'获取应用信息失败'**
  String get failedToGetAppInfo;

  /// URL跳转失败时的提示标题
  ///
  /// In zh, this message translates to:
  /// **'跳转失败'**
  String get jumpFailed;

  /// URL跳转失败时的提示消息
  ///
  /// In zh, this message translates to:
  /// **'跳转到\"{uri}\"失败'**
  String jumpToUriFailed(String uri);

  /// URL跳转过程中发生错误的提示消息
  ///
  /// In zh, this message translates to:
  /// **'跳转到\"{uri}\"时发生错误：{error}'**
  String jumpToUriError(String uri, String error);

  /// 更多选项的标题
  ///
  /// In zh, this message translates to:
  /// **'更多选项'**
  String get moreOptions;

  /// 批量创建模式复选框的标签
  ///
  /// In zh, this message translates to:
  /// **'批量创建模式'**
  String get batchCreationMode;

  /// 新建操作的文本
  ///
  /// In zh, this message translates to:
  /// **'新建'**
  String get createText;

  /// 编辑操作的文本
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get editText;

  /// 主要选项的标题
  ///
  /// In zh, this message translates to:
  /// **'主要选项'**
  String get mainOptions;

  /// 创建操作的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'创建'**
  String get create;

  /// 批量创建操作的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'批量创建'**
  String get batchCreate;

  /// 保存操作的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

  /// 创建完成提示的标题
  ///
  /// In zh, this message translates to:
  /// **'创建完成'**
  String get createComplete;

  /// 任务创建成功的提示消息
  ///
  /// In zh, this message translates to:
  /// **'成功创建了\"{title}\"任务项'**
  String taskCreateSuccess(String title);

  /// 修改完成提示的标题
  ///
  /// In zh, this message translates to:
  /// **'修改完成'**
  String get modifyComplete;

  /// 任务修改成功的提示消息
  ///
  /// In zh, this message translates to:
  /// **'成功修改了\"{title}\"任务项'**
  String taskModifySuccess(String title);

  /// 导出格式化的开关标签
  ///
  /// In zh, this message translates to:
  /// **'导出格式化'**
  String get exportFormat;

  /// 导出格式化的描述文本
  ///
  /// In zh, this message translates to:
  /// **'是否以易读（完整缩进换行）的Json导出'**
  String get exportFormatDescription;

  /// 导出模式的标题
  ///
  /// In zh, this message translates to:
  /// **'导出模式'**
  String get exportMode;

  /// Json格式的文本
  ///
  /// In zh, this message translates to:
  /// **'Json'**
  String get json;

  /// Base64格式的文本
  ///
  /// In zh, this message translates to:
  /// **'Base64'**
  String get base64;

  /// 导出任务菜单配置文件的开关标签
  ///
  /// In zh, this message translates to:
  /// **'导出任务菜单配置文件'**
  String get exportAppbarConfig;

  /// 导出所有任务的开关标签
  ///
  /// In zh, this message translates to:
  /// **'导出所有任务'**
  String get exportAllTaskItem;

  /// 导出到文件的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'导出到文件'**
  String get exportToFile;

  /// 导出到剪贴板的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'导出到剪贴板'**
  String get exportToClipboard;

  /// 用于保存到剪贴板时的完成提示
  ///
  /// In zh, this message translates to:
  /// **'剪贴板'**
  String get clipboard;

  /// 选择保存文件位置的对话框标题
  ///
  /// In zh, this message translates to:
  /// **'选择保存文件位置'**
  String get selectSaveFileLocation;

  /// 导出成功的提示标题
  ///
  /// In zh, this message translates to:
  /// **'导出成功'**
  String get exportSuccess;

  /// 导出成功的提示消息
  ///
  /// In zh, this message translates to:
  /// **'成功导出{type}数据到\"{destination}\"'**
  String exportSuccessMessage(String type, String destination);

  /// 导出错误的提示标题
  ///
  /// In zh, this message translates to:
  /// **'导出发生错误'**
  String get exportError;

  /// 导出取消的提示消息
  ///
  /// In zh, this message translates to:
  /// **'导出已取消'**
  String get exportCancelled;

  /// 导入数据的警告提示文本
  ///
  /// In zh, this message translates to:
  /// **'重要提示\n！导入数据后会完全删除原数据后覆盖！\n！此操作不可逆，且难以恢复！\n！请务必谨慎操作！'**
  String get importWarning;

  /// 从文件解析的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'从文件解析'**
  String get parseFromFile;

  /// 从剪贴板解析的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'从剪贴板解析'**
  String get parseFromClipboard;

  /// 覆盖保存的按钮文本
  ///
  /// In zh, this message translates to:
  /// **'覆盖保存'**
  String get overwriteSave;

  /// 数据信息的显示文本
  ///
  /// In zh, this message translates to:
  /// **'数据信息：\n    数据数量：{count}\n    数据列表：{keys}'**
  String dataInfo(int count, String keys);

  /// 解析成功的提示标题
  ///
  /// In zh, this message translates to:
  /// **'解析成功'**
  String get parseSuccess;

  /// 准备好覆盖内容的提示消息
  ///
  /// In zh, this message translates to:
  /// **'已经准备好覆盖内容'**
  String get readyToOverwrite;

  /// 解析失败的提示标题
  ///
  /// In zh, this message translates to:
  /// **'解析失败'**
  String get parseFailed;

  /// 剪贴板数据获取失败的提示标题
  ///
  /// In zh, this message translates to:
  /// **'剪贴板数据获取失败'**
  String get clipboardDataFailed;

  /// 剪贴板数据获取失败的提示消息
  ///
  /// In zh, this message translates to:
  /// **'请检查剪贴板或重新复制数据内容'**
  String get checkClipboardAndRetry;

  /// 解析覆盖完成的提示消息
  ///
  /// In zh, this message translates to:
  /// **'解析覆盖完成'**
  String get parseOverwriteComplete;

  /// 解析覆盖失败的提示标题
  ///
  /// In zh, this message translates to:
  /// **'解析覆盖失败'**
  String get parseOverwriteFailed;

  /// 选择数据文件的对话框标题
  ///
  /// In zh, this message translates to:
  /// **'选择数据文件'**
  String get selectDataFile;

  /// 默认任务的标题
  ///
  /// In zh, this message translates to:
  /// **'任务标题'**
  String get defaultTaskTitle;

  /// 默认任务的小标题
  ///
  /// In zh, this message translates to:
  /// **'任务小标题'**
  String get defaultTaskSubTitle;

  /// 默认任务的详细信息
  ///
  /// In zh, this message translates to:
  /// **'这里是任务详情，用于描述该任务\n这是一个可完成任务项，拥有：\n\t复选框 —— 用于标记该任务是否完成\n\t重要等级和重要性类型 —— 使用用于标记该任务的重要性和重要程度'**
  String get defaultTaskDetails;

  /// 可完成任务项的类型名称
  ///
  /// In zh, this message translates to:
  /// **'可完成任务项'**
  String get completableTaskItem;

  /// 重要性权重的显示文本
  ///
  /// In zh, this message translates to:
  /// **'重要性权重：{weight}'**
  String importanceWeight(int weight);

  /// 重要程度的显示文本
  ///
  /// In zh, this message translates to:
  /// **'重要程度：{level}'**
  String importanceLevelLabel(String level);

  /// 重要性类型的显示文本
  ///
  /// In zh, this message translates to:
  /// **'重要性类型：{type}'**
  String importanceTypeLabel(String type);

  /// 可完成任务项的描述
  ///
  /// In zh, this message translates to:
  /// **'创建一个可标记完成、分类和优先级的任务项'**
  String get completableTaskItemDescription;

  /// 重要程度：最低
  ///
  /// In zh, this message translates to:
  /// **'最低'**
  String get importanceLevelMinimum;

  /// 重要程度：低
  ///
  /// In zh, this message translates to:
  /// **'低'**
  String get importanceLevelLow;

  /// 重要程度：中
  ///
  /// In zh, this message translates to:
  /// **'中'**
  String get importanceLevelMedium;

  /// 重要程度：高
  ///
  /// In zh, this message translates to:
  /// **'高'**
  String get importanceLevelHigh;

  /// 重要程度：最高
  ///
  /// In zh, this message translates to:
  /// **'最高'**
  String get importanceLevelCritical;

  /// 重要程度的表单标签
  ///
  /// In zh, this message translates to:
  /// **'重要程度'**
  String get importanceLevel;

  /// 重要性类型的表单标签
  ///
  /// In zh, this message translates to:
  /// **'重要性类型'**
  String get importanceType;

  /// 是否完成的开关标签
  ///
  /// In zh, this message translates to:
  /// **'是否完成'**
  String get isFinished;

  /// 选择任务类型的标题
  ///
  /// In zh, this message translates to:
  /// **'选择任务类型'**
  String get selectTaskType;

  /// 新建任务的工具提示
  ///
  /// In zh, this message translates to:
  /// **'新建任务'**
  String get newTask;

  /// 标题的表单标签
  ///
  /// In zh, this message translates to:
  /// **'标题'**
  String get title;

  /// 副标题的表单标签
  ///
  /// In zh, this message translates to:
  /// **'副标题'**
  String get subTitle;

  /// 详细信息的表单标签
  ///
  /// In zh, this message translates to:
  /// **'详细信息'**
  String get details;

  /// 是否启用的开关标签
  ///
  /// In zh, this message translates to:
  /// **'是否启用'**
  String get isEnabled;

  /// 标题不能为空的验证错误信息
  ///
  /// In zh, this message translates to:
  /// **'标题不可为空'**
  String get titleCannotBeEmpty;

  /// 标题不能重复的验证错误信息
  ///
  /// In zh, this message translates to:
  /// **'标题不可与现有项重复'**
  String get titleCannotDuplicate;

  /// 仍在开发中的占位文本
  ///
  /// In zh, this message translates to:
  /// **'仍在开发中...'**
  String get stillInDevelopment;

  /// 编辑操作的滑动操作标签
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get edit;

  /// 删除操作的滑动操作标签
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get delete;

  /// 标题的显示标签
  ///
  /// In zh, this message translates to:
  /// **'标题：{title}'**
  String titleLabel(String title);

  /// 副标题的显示标签
  ///
  /// In zh, this message translates to:
  /// **'副标题：{subTitle}'**
  String subTitleLabel(String subTitle);

  /// 创建时间的显示标签
  ///
  /// In zh, this message translates to:
  /// **'创建时间：{dateTime}'**
  String createTimeLabel(String dateTime);

  /// 最后更改时间的显示标签
  ///
  /// In zh, this message translates to:
  /// **'最后更改：{dateTime}'**
  String updateTimeLabel(String dateTime);

  /// 没有详细信息时的占位文本
  ///
  /// In zh, this message translates to:
  /// **'（暂无详细信息）'**
  String get noDetails;

  /// 任务信息页面的标题
  ///
  /// In zh, this message translates to:
  /// **'\"{title}\"任务信息'**
  String taskInfoTitle(String title);

  /// 编辑任务的按钮文本和工具提示
  ///
  /// In zh, this message translates to:
  /// **'编辑任务'**
  String get editTask;

  /// 排序方式的标题
  ///
  /// In zh, this message translates to:
  /// **'排序方式：'**
  String get sortMethod;

  /// 升序排序的标签
  ///
  /// In zh, this message translates to:
  /// **'升序'**
  String get ascending;

  /// 降序排序的标签
  ///
  /// In zh, this message translates to:
  /// **'降序'**
  String get descending;

  /// 选择后自动关闭的复选框标签
  ///
  /// In zh, this message translates to:
  /// **'选择类型后自动关闭当前页'**
  String get autoCloseAfterSelection;

  /// 按重要程度排序的选项
  ///
  /// In zh, this message translates to:
  /// **'按照重要程度排序'**
  String get sortByImportance;

  /// 按名称排序的选项
  ///
  /// In zh, this message translates to:
  /// **'按照名称排序'**
  String get sortByName;

  /// 按最后修改日期排序的选项
  ///
  /// In zh, this message translates to:
  /// **'按照最后修改日期排序'**
  String get sortByUpdateDate;

  /// 按创建日期排序的选项
  ///
  /// In zh, this message translates to:
  /// **'按照创建日期排序'**
  String get sortByDate;

  /// 重要性类型：不重要不紧急
  ///
  /// In zh, this message translates to:
  /// **'不重要不紧急'**
  String get importanceTypeNotImportantNotUrgent;

  /// 重要性类型：紧急不重要
  ///
  /// In zh, this message translates to:
  /// **'紧急不重要'**
  String get importanceTypeUrgentNotImportant;

  /// 重要性类型：重要不紧急
  ///
  /// In zh, this message translates to:
  /// **'重要不紧急'**
  String get importanceTypeImportantNotUrgent;

  /// 重要性类型：重要且紧急
  ///
  /// In zh, this message translates to:
  /// **'重要且紧急'**
  String get importanceTypeImportantAndUrgent;

  /// JSON反序列化时type值为null的错误信息
  ///
  /// In zh, this message translates to:
  /// **'反序列化失败：type值为null'**
  String get deserializationFailedTypeNull;

  /// JSON反序列化时遇到未知类型的错误信息
  ///
  /// In zh, this message translates to:
  /// **'反序列化失败：未知的类型{type}'**
  String deserializationFailedUnknownType(String type);

  /// 基本信息分类的标题
  ///
  /// In zh, this message translates to:
  /// **'基本信息'**
  String get basicInformation;

  /// 详细信息分类的标题
  ///
  /// In zh, this message translates to:
  /// **'详细信息'**
  String get detailedInformation;

  /// 删除操作成功后的提示标题
  ///
  /// In zh, this message translates to:
  /// **'删除成功'**
  String get deleteSuccess;

  /// 任务删除成功后的提示消息
  ///
  /// In zh, this message translates to:
  /// **'成功删除了\"{title}\"任务项'**
  String taskDeleteSuccess(String title);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
