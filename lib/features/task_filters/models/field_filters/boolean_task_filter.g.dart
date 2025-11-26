// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanTaskFilter _$BooleanTaskFilterFromJson(Map<String, dynamic> json) =>
    BooleanTaskFilter(
        field: json['field'] as String,
        mode: $enumDecode(_$BooleanMatchModeEnumMap, json['mode']),
        pattern: json['pattern'] as bool? ?? false,
      )
      ..isReverse = json['isReverse'] as bool
      ..isValid = json['isValid'] as bool;

Map<String, dynamic> _$BooleanTaskFilterToJson(BooleanTaskFilter instance) =>
    <String, dynamic>{
      'isReverse': instance.isReverse,
      'isValid': instance.isValid,
      'field': instance.field,
      'mode': _$BooleanMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern,
    };

const _$BooleanMatchModeEnumMap = {
  BooleanMatchMode.exact: 'exact',
  BooleanMatchMode.and: 'and',
  BooleanMatchMode.or: 'or',
  BooleanMatchMode.not: 'not',
  BooleanMatchMode.xor: 'xor',
};
