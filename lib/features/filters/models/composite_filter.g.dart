// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composite_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompositeFilter _$CompositeFilterFromJson(Map<String, dynamic> json) =>
    CompositeFilter(
        filterList: (json['filterList'] as List<dynamic>?)
            ?.map(
              (e) => const TaskFilterConverter().fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        isAndLogic: json['isAndLogic'] as bool? ?? false,
      )
      ..isReverse = json['isReverse'] as bool
      ..isValid = json['isValid'] as bool;

Map<String, dynamic> _$CompositeFilterToJson(CompositeFilter instance) =>
    <String, dynamic>{
      'isReverse': instance.isReverse,
      'isValid': instance.isValid,
      'filterList': instance.filterList
          .map(const TaskFilterConverter().toJson)
          .toList(),
      'isAndLogic': instance.isAndLogic,
    };
