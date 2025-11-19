// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextTaskFilter _$TextTaskFilterFromJson(Map<String, dynamic> json) =>
    TextTaskFilter(
      field: $enumDecode(_$TaskItemTextFieldEnumMap, json['field']),
      mode:
          $enumDecodeNullable(_$TextMatchModeEnumMap, json['mode']) ??
          TextMatchMode.exact,
      pattern: json['pattern'] as String? ?? '',
    );

Map<String, dynamic> _$TextTaskFilterToJson(TextTaskFilter instance) =>
    <String, dynamic>{
      'field': _$TaskItemTextFieldEnumMap[instance.field]!,
      'mode': _$TextMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern,
    };

const _$TaskItemTextFieldEnumMap = {
  TaskItemTextField.title: 'title',
  TaskItemTextField.subTitle: 'subTitle',
  TaskItemTextField.details: 'details',
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
