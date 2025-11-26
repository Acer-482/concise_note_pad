// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeTaskFilter _$DateTimeTaskFilterFromJson(Map<String, dynamic> json) =>
    DateTimeTaskFilter(
        field: json['field'] as String,
        mode: $enumDecode(_$DateTimeMatchModeEnumMap, json['mode']),
        pattern: json['pattern'] == null
            ? null
            : DateTime.parse(json['pattern'] as String),
      )
      ..isReverse = json['isReverse'] as bool
      ..isValid = json['isValid'] as bool;

Map<String, dynamic> _$DateTimeTaskFilterToJson(DateTimeTaskFilter instance) =>
    <String, dynamic>{
      'isReverse': instance.isReverse,
      'isValid': instance.isValid,
      'field': instance.field,
      'mode': _$DateTimeMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern.toIso8601String(),
    };

const _$DateTimeMatchModeEnumMap = {
  DateTimeMatchMode.exactYear: 'exactYear',
  DateTimeMatchMode.exactMonth: 'exactMonth',
  DateTimeMatchMode.exactDay: 'exactDay',
  DateTimeMatchMode.exact: 'exact',
  DateTimeMatchMode.before: 'before',
  DateTimeMatchMode.after: 'after',
};
