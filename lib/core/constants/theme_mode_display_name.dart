import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// 主题模式显示名称
extension ThemeModeDisplayName on ThemeMode {
  String displayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return switch (this) {
      ThemeMode.system => loc.themeModeDisplayName_system,
      ThemeMode.light => loc.themeModeDisplayName_light,
      ThemeMode.dark => loc.themeModeDisplayName_dark,
    };
  }
}
