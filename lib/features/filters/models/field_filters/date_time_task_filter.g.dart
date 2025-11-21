// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeTaskFilter _$DateTimeTaskFilterFromJson(Map<String, dynamic> json) =>
    DateTimeTaskFilter(
      field: DateTime.parse(json['field'] as String),
      mode: $enumDecode(_$DateTimeMatchModeEnumMap, json['mode']),
      pattern: json['pattern'] == null
          ? const Duration(seconds: 1)
          : Duration(microseconds: (json['pattern'] as num).toInt()),
    );

Map<String, dynamic> _$DateTimeTaskFilterToJson(DateTimeTaskFilter instance) =>
    <String, dynamic>{
      'field': instance.field.toIso8601String(),
      'mode': _$DateTimeMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern.inMicroseconds,
    };

const _$DateTimeMatchModeEnumMap = {DateTimeMatchMode.exact: 'exact'};
