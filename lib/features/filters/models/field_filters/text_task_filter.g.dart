// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextTaskFilter _$TextTaskFilterFromJson(Map<String, dynamic> json) =>
    TextTaskFilter(
        field: json['field'] as String,
        mode: $enumDecode(_$TextMatchModeEnumMap, json['mode']),
        pattern: json['pattern'] as String? ?? '',
      )
      ..isReverse = json['isReverse'] as bool
      ..isValid = json['isValid'] as bool;

Map<String, dynamic> _$TextTaskFilterToJson(TextTaskFilter instance) =>
    <String, dynamic>{
      'isReverse': instance.isReverse,
      'isValid': instance.isValid,
      'field': instance.field,
      'mode': _$TextMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern,
    };

const _$TextMatchModeEnumMap = {
  TextMatchMode.contains: 'contains',
  TextMatchMode.exact: 'exact',
  TextMatchMode.startsWith: 'startsWith',
  TextMatchMode.endsWith: 'endsWith',
  TextMatchMode.isEmpty: 'isEmpty',
  TextMatchMode.isNotEmpty: 'isNotEmpty',
  TextMatchMode.regex: 'regex',
};
