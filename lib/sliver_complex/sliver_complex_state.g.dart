// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sliver_complex_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliverComplexState _$SliverComplexStateFromJson(Map<String, dynamic> json) =>
    SliverComplexState(
      isReverseSort: json['isReverseSort'] as bool? ?? true,
      sortOption:
          $enumDecodeNullable(_$SortOptionEnumMap, json['sortOption']) ??
          SortOption.importance,
      isSortOptionAutoClose: json['isSortOptionAutoClose'] as bool? ?? true,
    );

Map<String, dynamic> _$SliverComplexStateToJson(SliverComplexState instance) =>
    <String, dynamic>{
      'isReverseSort': instance.isReverseSort,
      'sortOption': _$SortOptionEnumMap[instance.sortOption]!,
      'isSortOptionAutoClose': instance.isSortOptionAutoClose,
    };

const _$SortOptionEnumMap = {
  SortOption.importance: 'importance',
  SortOption.name: 'name',
  SortOption.updateDate: 'updateDate',
  SortOption.date: 'date',
};
