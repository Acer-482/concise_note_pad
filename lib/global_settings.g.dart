// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalSettings _$GlobalSettingsFromJson(Map<String, dynamic> json) =>
    GlobalSettings(
      themeColor: json['themeColor'] == null
          ? Colors.cyan
          : const ColorDataConverter().fromJson(
              json['themeColor'] as Map<String, dynamic>,
            ),
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
    );

Map<String, dynamic> _$GlobalSettingsToJson(GlobalSettings instance) =>
    <String, dynamic>{
      'themeColor': const ColorDataConverter().toJson(instance.themeColor),
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
