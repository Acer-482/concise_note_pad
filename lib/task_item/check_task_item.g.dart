// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletableTaskItem _$CompletableTaskItemFromJson(Map<String, dynamic> json) =>
    CompletableTaskItem(
      title: json['title'] as String,
      subTitle: json['subTitle'] as String? ?? '',
      details: json['details'] as String? ?? '',
      isEnabled: json['isEnabled'] as bool? ?? true,
      createDateTime: json['createDateTime'] == null
          ? null
          : DateTime.parse(json['createDateTime'] as String),
      updateDateTime: json['updateDateTime'] == null
          ? null
          : DateTime.parse(json['updateDateTime'] as String),
      isChecked: json['isChecked'] as bool? ?? false,
      importanceLevel: $enumDecodeNullable(
        _$ImportanceLevelEnumMap,
        json['importanceLevel'],
      ),
      importanceType: $enumDecodeNullable(
        _$ImportanceTypeEnumMap,
        json['importanceType'],
      ),
    );

Map<String, dynamic> _$CompletableTaskItemToJson(
  CompletableTaskItem instance,
) => <String, dynamic>{
  'title': instance.title,
  'subTitle': instance.subTitle,
  'details': instance.details,
  'isEnabled': instance.isEnabled,
  'createDateTime': instance.createDateTime.toIso8601String(),
  'updateDateTime': instance.updateDateTime.toIso8601String(),
  'isChecked': instance.isChecked,
  'importanceLevel': _$ImportanceLevelEnumMap[instance.importanceLevel]!,
  'importanceType': _$ImportanceTypeEnumMap[instance.importanceType]!,
};

const _$ImportanceLevelEnumMap = {
  ImportanceLevel.minimum: 'minimum',
  ImportanceLevel.low: 'low',
  ImportanceLevel.medium: 'medium',
  ImportanceLevel.high: 'high',
  ImportanceLevel.critical: 'critical',
};

const _$ImportanceTypeEnumMap = {
  ImportanceType.notImportantNotUrgent: 'notImportantNotUrgent',
  ImportanceType.urgentNotImportant: 'urgentNotImportant',
  ImportanceType.importantNotUrgent: 'importantNotUrgent',
  ImportanceType.importantAndUrgent: 'importantAndUrgent',
};
