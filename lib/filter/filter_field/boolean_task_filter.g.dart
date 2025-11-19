// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanTaskFilter _$BooleanTaskFilterFromJson(Map<String, dynamic> json) =>
    BooleanTaskFilter(
      field: $enumDecode(_$TaskItemBooleanFieldEnumMap, json['field']),
      mode: $enumDecode(_$BooleanMatchModeEnumMap, json['mode']),
      pattern: json['pattern'] as bool? ?? false,
    );

Map<String, dynamic> _$BooleanTaskFilterToJson(BooleanTaskFilter instance) =>
    <String, dynamic>{
      'field': _$TaskItemBooleanFieldEnumMap[instance.field]!,
      'mode': _$BooleanMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern,
    };

const _$TaskItemBooleanFieldEnumMap = {
  TaskItemBooleanField.isEnabled: 'isEnabled',
};

const _$BooleanMatchModeEnumMap = {
  BooleanMatchMode.exact: 'exact',
  BooleanMatchMode.and: 'and',
  BooleanMatchMode.or: 'or',
  BooleanMatchMode.not: 'not',
  BooleanMatchMode.xor: 'xor',
};
