// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationTaskFilter _$DurationTaskFilterFromJson(Map<String, dynamic> json) =>
    DurationTaskFilter(
        field: json['field'] as String,
        mode: $enumDecode(_$DurationMatchModeEnumMap, json['mode']),
        pattern: json['pattern'] == null
            ? Duration.zero
            : Duration(microseconds: (json['pattern'] as num).toInt()),
      )
      ..isReverse = json['isReverse'] as bool
      ..isValid = json['isValid'] as bool;

Map<String, dynamic> _$DurationTaskFilterToJson(DurationTaskFilter instance) =>
    <String, dynamic>{
      'isReverse': instance.isReverse,
      'isValid': instance.isValid,
      'field': instance.field,
      'mode': _$DurationMatchModeEnumMap[instance.mode]!,
      'pattern': instance.pattern.inMicroseconds,
    };

const _$DurationMatchModeEnumMap = {
  DurationMatchMode.within: 'within',
  DurationMatchMode.withinInLast: 'withinInLast',
  DurationMatchMode.withinInNext: 'withinInNext',
  DurationMatchMode.without: 'without',
  DurationMatchMode.withoutInLast: 'withoutInLast',
  DurationMatchMode.withoutInNext: 'withoutInNext',
};
