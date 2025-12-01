// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Simple Notes';

  @override
  String get languageType_system => 'System';

  @override
  String get themeModeDisplayName_system => 'System';

  @override
  String get themeModeDisplayName_light => 'Light';

  @override
  String get themeModeDisplayName_dark => 'Dark';

  @override
  String get fontFamilyType_system => 'System Default';

  @override
  String get fontFamilyType_alibabaPuHuiTi => 'Alibaba PuHuiTi';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsGroupGlobal => 'Global Settings';

  @override
  String get resetAllSettings => 'Reset All Settings';

  @override
  String get reset => 'Reset';

  @override
  String get language => 'Language';

  @override
  String get settingsGroupTheme => 'Theme';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get themeColor => 'Theme Color';

  @override
  String get pickColor => 'Pick Color';

  @override
  String get themeFont => 'Theme Font';

  @override
  String get selectThemeColor => 'Select Theme Color';

  @override
  String get confirmDialogDefaultTitle => 'Confirm?';

  @override
  String confirmDialogMessage(String text) {
    return 'Are you sure you want to $text?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmDialogTitle => 'Confirm?';

  @override
  String get confirmDialogDefaultMessage => 'This action cannot be undone!';

  @override
  String get success => 'Operation successful';

  @override
  String get resetSuccess => 'Reset successful';

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationTasks => 'Tasks';

  @override
  String get drawerTitle => 'Sidebar';

  @override
  String get drawerSettings => 'Settings';

  @override
  String get drawerAbout => 'About';

  @override
  String get aboutPageTitle => 'About';

  @override
  String get more => 'More';

  @override
  String get moreLicenseInfo => 'More License Information';

  @override
  String get goToGithubRepo => 'Go to GitHub Repository';

  @override
  String get githubRepoUrl => 'https://github.com/Acer-482/concise_note_pad';

  @override
  String versionWithParam(String version) {
    return 'Version $version';
  }

  @override
  String get softwareLicense =>
      'This software is licensed under the GPL-3.0 License';

  @override
  String get copyright => 'Copyright © 2025 Acer';

  @override
  String get failedToGetAppInfo => 'Failed to get application information';

  @override
  String get jumpFailed => 'Jump failed';

  @override
  String jumpToUriFailed(String uri) {
    return 'Failed to jump to \"$uri\"';
  }

  @override
  String jumpToUriError(String uri, String error) {
    return 'Error occurred while jumping to \"$uri\": $error';
  }

  @override
  String get moreOptions => 'More Options';

  @override
  String get batchCreationMode => 'Batch Creation Mode';

  @override
  String get createText => 'New';

  @override
  String get editText => 'Edit';

  @override
  String get mainOptions => 'Main Options';

  @override
  String get create => 'Create';

  @override
  String get batchCreate => 'Batch Create';

  @override
  String get save => 'Save';

  @override
  String get createComplete => 'Creation Complete';

  @override
  String taskCreateSuccess(String title) {
    return 'Successfully created task item \"$title\"';
  }

  @override
  String get modifyComplete => 'Modification Complete';

  @override
  String taskModifySuccess(String title) {
    return 'Successfully modified task item \"$title\"';
  }

  @override
  String get exportFormat => 'Export Formatting';

  @override
  String get exportFormatDescription =>
      'Whether to export as human-readable (full indentation and line breaks) JSON';

  @override
  String get exportMode => 'Export Mode';

  @override
  String get json => 'Json';

  @override
  String get base64 => 'Base64';

  @override
  String get exportAppbarConfig => 'Export Task Menu Configuration File';

  @override
  String get exportAllTaskItem => 'Export All Tasks';

  @override
  String get exportToFile => 'Export to File';

  @override
  String get exportToClipboard => 'Export to Clipboard';

  @override
  String get clipboard => 'Clipboard';

  @override
  String get selectSaveFileLocation => 'Select Save File Location';

  @override
  String get exportSuccess => 'Export Successful';

  @override
  String exportSuccessMessage(String type, String destination) {
    return 'Successfully exported $type data to \"$destination\"';
  }

  @override
  String get exportError => 'Export Error';

  @override
  String get exportCancelled => 'Export Cancelled';

  @override
  String get importWarning =>
      'Important Notice\n! Importing data will completely delete the original data and overwrite it!\n! This operation is irreversible and difficult to recover!\n! Please proceed with caution!';

  @override
  String get parseFromFile => 'Parse from File';

  @override
  String get parseFromClipboard => 'Parse from Clipboard';

  @override
  String get overwriteSave => 'Overwrite and Save';

  @override
  String dataInfo(int count, String keys) {
    return 'Data Info:\n    Data Count: $count\n    Data List: $keys';
  }

  @override
  String get parseSuccess => 'Parse Successful';

  @override
  String get readyToOverwrite => 'Ready to overwrite content';

  @override
  String get parseFailed => 'Parse Failed';

  @override
  String get clipboardDataFailed => 'Clipboard Data Fetch Failed';

  @override
  String get checkClipboardAndRetry =>
      'Please check clipboard or copy data content again';

  @override
  String get parseOverwriteComplete => 'Parse and Overwrite Complete';

  @override
  String get parseOverwriteFailed => 'Parse and Overwrite Failed';

  @override
  String get selectDataFile => 'Select Data File';

  @override
  String get defaultTaskTitle => 'Task Title';

  @override
  String get defaultTaskSubTitle => 'Task Subtitle';

  @override
  String get defaultTaskDetails =>
      'This is the task details, used to describe the task.\nThis is a completable task item, which has:\n\tCheckbox – Used to mark whether the task is completed\n\tImportance level and importance type – Used to mark the importance and priority of the task';

  @override
  String get completableTaskItem => 'Completable Task Item';

  @override
  String importanceWeight(int weight) {
    return 'Importance Weight: $weight';
  }

  @override
  String importanceLevelLabel(String level) {
    return 'Importance Level: $level';
  }

  @override
  String importanceTypeLabel(String type) {
    return 'Importance Type: $type';
  }

  @override
  String get completableTaskItemDescription =>
      'Create a task item that can be marked complete, categorized, and prioritized';

  @override
  String get importanceLevelMinimum => 'Minimum';

  @override
  String get importanceLevelLow => 'Low';

  @override
  String get importanceLevelMedium => 'Medium';

  @override
  String get importanceLevelHigh => 'High';

  @override
  String get importanceLevelCritical => 'Critical';

  @override
  String get importanceLevel => 'Importance Level';

  @override
  String get importanceType => 'Importance Type';

  @override
  String get isFinished => 'Is Finished';

  @override
  String get selectTaskType => 'Select Task Type';

  @override
  String get newTask => 'New Task';

  @override
  String get title => 'Title';

  @override
  String get subTitle => 'Subtitle';

  @override
  String get details => 'Details';

  @override
  String get isEnabled => 'Is Enabled';

  @override
  String get titleCannotBeEmpty => 'Title cannot be empty';

  @override
  String get titleCannotDuplicate => 'Title cannot duplicate existing items';

  @override
  String get stillInDevelopment => 'Still in development...';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String titleLabel(String title) {
    return 'Title: $title';
  }

  @override
  String subTitleLabel(String subTitle) {
    return 'Subtitle: $subTitle';
  }

  @override
  String createTimeLabel(String dateTime) {
    return 'Creation Time: $dateTime';
  }

  @override
  String updateTimeLabel(String dateTime) {
    return 'Last Modified: $dateTime';
  }

  @override
  String get noDetails => '(No details yet)';

  @override
  String taskInfoTitle(String title) {
    return '\"$title\" Task Information';
  }

  @override
  String get editTask => 'Edit Task';

  @override
  String get sortMethod => 'Sort Method:';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get autoCloseAfterSelection =>
      'Auto close current page after selecting type';

  @override
  String get sortByImportance => 'Sort by Importance Level';

  @override
  String get sortByName => 'Sort by Name';

  @override
  String get sortByUpdateDate => 'Sort by Last Modified Date';

  @override
  String get sortByDate => 'Sort by Creation Date';

  @override
  String get importanceTypeNotImportantNotUrgent => 'Not Important Not Urgent';

  @override
  String get importanceTypeUrgentNotImportant => 'Urgent Not Important';

  @override
  String get importanceTypeImportantNotUrgent => 'Important Not Urgent';

  @override
  String get importanceTypeImportantAndUrgent => 'Important and Urgent';

  @override
  String get deserializationFailedTypeNull =>
      'Desialization failed: type value is null';

  @override
  String deserializationFailedUnknownType(String type) {
    return 'Desialization failed: Unknown type $type';
  }

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get detailedInformation => 'Details';

  @override
  String get deleteSuccess => 'Deleted successfully';

  @override
  String taskDeleteSuccess(String title) {
    return 'Successfully deleted the task item \"$title\"';
  }
}
