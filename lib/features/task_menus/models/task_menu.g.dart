// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskMenu _$TaskMenuFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['state']);
  return TaskMenu(
    state: json['state'] == null
        ? null
        : TaskMenuState.fromJson(json['state'] as Map<String, dynamic>),
    iconData: _$JsonConverterFromJson<Map<String, dynamic>, IconData>(
      json['iconData'],
      const IconDataConverter().fromJson,
    ),
    title: json['title'] as String?,
    isPinned: json['pinned'] as bool?,
  );
}

Map<String, dynamic> _$TaskMenuToJson(TaskMenu instance) => <String, dynamic>{
  'state': instance.state,
  'iconData': _$JsonConverterToJson<Map<String, dynamic>, IconData>(
    instance.iconData,
    const IconDataConverter().toJson,
  ),
  'title': instance.title,
  'pinned': instance.isPinned,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
