import 'package:concise_note_pad/core/converters/icon_data_converter.dart';
import 'package:concise_note_pad/features/tasks/sliver_complexs/sliver_complex_appbar.dart';
import 'package:concise_note_pad/features/tasks/sliver_complexs/sliver_complex_list.dart';
import 'package:concise_note_pad/features/tasks/sliver_complexs/sliver_complex_state.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sliver_complex.g.dart';

/// 薄片复合项
///
/// 复合应用栏和列表
@JsonSerializable(ignoreUnannotated: true)
class SliverComplex {
  @JsonKey(required: true)
  final SliverComplexState state; // 状态
  final SliverComplexAppbar appbar; // 应用栏
  final SliverComplexList list; // 列表

  @JsonKey()
  @IconDataConverter()
  final IconData? iconData;
  @JsonKey()
  final String title;
  @JsonKey()
  final bool pinned;

  SliverComplex({
    SliverComplexState? state,
    this.iconData,
    String? title,
    bool? pinned,
  }) : state = state ?? SliverComplexState(),
       title = title ?? '',
       pinned = pinned ?? false,
       appbar = SliverComplexAppbar(
         // 在初始化列表中初始化
         iconData: iconData,
         title: title ?? '',
         pinned: pinned ?? false,
         state: state ?? SliverComplexState(),
       ),
       list = SliverComplexList(
         // 在初始化列表中初始化
         state: state ?? SliverComplexState(),
       );

  factory SliverComplex.fromJson(Map<String, dynamic> json) =>
      _$SliverComplexFromJson(json);
  Map<String, dynamic> toJson() => _$SliverComplexToJson(this);

  /// 添加到列表
  void addToList(List<dynamic> l) {
    l.add(appbar);
    l.add(list);
  }

  /// 销毁
  void dispose() {
    state.dispose();
  }
}
