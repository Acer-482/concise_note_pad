// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Concise Note';

  @override
  String get languageType_system => 'Follow System';

  @override
  String get themeModeDisplayName_system => 'Follow System';

  @override
  String get themeModeDisplayName_light => 'Light';

  @override
  String get themeModeDisplayName_dark => 'Dark';

  @override
  String get fontFamilyType_system => 'System Default';

  @override
  String get fontFamilyType_alibabaPuHuiTi => 'Alibaba PuHuiTi';

  @override
  String get deleteConfirmDialogTitle => 'Confirm Delete?';

  @override
  String get deleteConfirmDialogDefaultMessage =>
      'This will delete the item and cannot be recovered!';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get deleteSuccess => 'Delete Successful';

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
  String get softwareLicense => 'This software is licensed under GPL-3.0';

  @override
  String get copyright => 'Copyright © 2025 Acer';

  @override
  String get failedToGetAppInfo => 'Failed to get application information';

  @override
  String get jumpFailed => 'Jump Failed';

  @override
  String jumpToUriFailed(String uri) {
    return 'Failed to jump to \"$uri\"';
  }

  @override
  String jumpToUriError(String uri, String error) {
    return 'Error occurred when jumping to \"$uri\": $error';
  }
}
