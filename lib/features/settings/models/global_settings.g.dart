// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalSettings _$GlobalSettingsFromJson(Map<String, dynamic> json) =>
    GlobalSettings(
      themeColor: _$JsonConverterFromJson<Map<String, dynamic>, Color>(
        json['themeColor'],
        const ColorDataConverter().fromJson,
      ),
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
    );

Map<String, dynamic> _$GlobalSettingsToJson(GlobalSettings instance) =>
    <String, dynamic>{
      'themeColor': const ColorDataConverter().toJson(instance.themeColor),
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
