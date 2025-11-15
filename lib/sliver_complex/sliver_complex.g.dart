// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sliver_complex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliverComplex _$SliverComplexFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['state']);
  return SliverComplex(
    state: json['state'] == null
        ? null
        : SliverComplexState.fromJson(json['state'] as Map<String, dynamic>),
    iconData: _$JsonConverterFromJson<Map<String, dynamic>, IconData>(
      json['iconData'],
      const IconDataConverter().fromJson,
    ),
    title: json['title'] as String?,
    pinned: json['pinned'] as bool?,
  );
}

Map<String, dynamic> _$SliverComplexToJson(SliverComplex instance) =>
    <String, dynamic>{
      'state': instance.state,
      'iconData': _$JsonConverterToJson<Map<String, dynamic>, IconData>(
        instance.iconData,
        const IconDataConverter().toJson,
      ),
      'title': instance.title,
      'pinned': instance.pinned,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
