// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composite_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompositeFilter _$CompositeFilterFromJson(Map<String, dynamic> json) =>
    CompositeFilter(
      filterList:
          (json['filterList'] as List<dynamic>?)
              ?.map(
                (e) => const TaskFilterConverter().fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
      isAndLogic: json['isAndLogic'] as bool? ?? false,
    );

Map<String, dynamic> _$CompositeFilterToJson(CompositeFilter instance) =>
    <String, dynamic>{
      'filterList': instance.filterList
          .map(const TaskFilterConverter().toJson)
          .toList(),
      'isAndLogic': instance.isAndLogic,
    };
