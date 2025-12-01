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

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Concise Note'**
  String get appName;

  /// Language type enum: Follow system settings
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get languageType_system;

  /// Theme mode: Follow system settings
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get themeModeDisplayName_system;

  /// Theme mode: Light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeDisplayName_light;

  /// Theme mode: Dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDisplayName_dark;

  /// Font family type: System default font
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get fontFamilyType_system;

  /// Font family type: Alibaba PuHuiTi font
  ///
  /// In en, this message translates to:
  /// **'Alibaba PuHuiTi'**
  String get fontFamilyType_alibabaPuHuiTi;

  /// Title of the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// Title of the global settings group
  ///
  /// In en, this message translates to:
  /// **'Global Settings'**
  String get settingsGroupGlobal;

  /// List item title for resetting all settings
  ///
  /// In en, this message translates to:
  /// **'Reset All Settings'**
  String get resetAllSettings;

  /// Button text for reset operation
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// List item title for language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Title of the theme settings group
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsGroupTheme;

  /// List item title for theme mode setting
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// List item title for theme color setting
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get themeColor;

  /// Button text for color selection
  ///
  /// In en, this message translates to:
  /// **'Pick Color'**
  String get pickColor;

  /// List item title for theme font setting
  ///
  /// In en, this message translates to:
  /// **'Theme Font'**
  String get themeFont;

  /// Title of the color picker dialog
  ///
  /// In en, this message translates to:
  /// **'Select Theme Color'**
  String get selectThemeColor;

  /// Default title for confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm?'**
  String get confirmDialogDefaultTitle;

  /// Message content for confirmation dialog, with parameter
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to {text}?'**
  String confirmDialogMessage(String text);

  /// Generic cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Title of confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm?'**
  String get confirmDialogTitle;

  /// Default message content for confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This operation cannot be recovered!'**
  String get confirmDialogDefaultMessage;

  /// Success message after operation
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get success;

  /// Success message after reset successful operation
  ///
  /// In en, this message translates to:
  /// **'Reset successful'**
  String get resetSuccess;

  /// Home page navigation item label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHome;

  /// Tasks page navigation item label
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get navigationTasks;

  /// Title of drawer menu
  ///
  /// In en, this message translates to:
  /// **'Sidebar'**
  String get drawerTitle;

  /// Settings item in drawer menu
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// About item in drawer menu
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get drawerAbout;

  /// About page: Title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutPageTitle;

  /// Title of 'More' section in about page
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// Button text to view more license information
  ///
  /// In en, this message translates to:
  /// **'More License Information'**
  String get moreLicenseInfo;

  /// Button text to jump to GitHub repository
  ///
  /// In en, this message translates to:
  /// **'Go to GitHub Repository'**
  String get goToGithubRepo;

  /// GitHub repository URL displayed on about page
  ///
  /// In en, this message translates to:
  /// **'https://github.com/Acer-482/concise_note_pad'**
  String get githubRepoUrl;

  /// Version number prefix text with version parameter
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionWithParam(String version);

  /// Software license statement
  ///
  /// In en, this message translates to:
  /// **'This software is licensed under GPL-3.0'**
  String get softwareLicense;

  /// Copyright statement
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2025 Acer'**
  String get copyright;

  /// Error message when package information retrieval fails
  ///
  /// In en, this message translates to:
  /// **'Failed to get application information'**
  String get failedToGetAppInfo;

  /// Title for URL jump failure notification
  ///
  /// In en, this message translates to:
  /// **'Jump Failed'**
  String get jumpFailed;

  /// Notification message for URL jump failure
  ///
  /// In en, this message translates to:
  /// **'Failed to jump to \"{uri}\"'**
  String jumpToUriFailed(String uri);

  /// Notification message for error during URL jump
  ///
  /// In en, this message translates to:
  /// **'Error occurred when jumping to \"{uri}\": {error}'**
  String jumpToUriError(String uri, String error);
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
