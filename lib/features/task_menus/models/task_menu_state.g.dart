// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_menu_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskMenuState _$TaskMenuStateFromJson(Map<String, dynamic> json) =>
    TaskMenuState(
      compositeFilter: json['compositeFilter'] == null
          ? null
          : CompositeFilter.fromJson(
              json['compositeFilter'] as Map<String, dynamic>,
            ),
      isReverseSort: json['isReverseSort'] as bool? ?? true,
      sortOption:
          $enumDecodeNullable(_$SortOptionEnumMap, json['sortOption']) ??
          SortOption.importance,
      isSortOptionAutoClose: json['isSortOptionAutoClose'] as bool? ?? true,
    );

Map<String, dynamic> _$TaskMenuStateToJson(TaskMenuState instance) =>
    <String, dynamic>{
      'compositeFilter': instance.compositeFilter,
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
