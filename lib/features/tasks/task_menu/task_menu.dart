import 'package:concise_note_pad/core/converters/icon_data_converter.dart';
import 'package:concise_note_pad/features/tasks/task_menu/task_menu_appbar.dart';
import 'package:concise_note_pad/features/tasks/task_menu/task_menu_list.dart';
import 'package:concise_note_pad/features/tasks/task_menu/task_menu_state.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_menu.g.dart';

/// 任务菜单栏
///
/// 管理、整合 应用栏和列表
@JsonSerializable(ignoreUnannotated: true)
class TaskMenu {
  @JsonKey(required: true)
  final TaskMenuState state; // 状态
  final TaskMenuAppbar appbar; // 应用栏
  final TaskMenuList list; // 列表

  @JsonKey()
  @IconDataConverter()
  final IconData? iconData;
  @JsonKey()
  final String title;
  @JsonKey()
  final bool pinned;

  TaskMenu({
    TaskMenuState? state,
    this.iconData,
    String? title,
    bool? pinned,
  }) : state = state ?? TaskMenuState(),
       title = title ?? '',
       pinned = pinned ?? false,
       appbar = TaskMenuAppbar(
         // 在初始化列表中初始化
         iconData: iconData,
         title: title ?? '',
         pinned: pinned ?? false,
         state: state ?? TaskMenuState(),
       ),
       list = TaskMenuList(
         // 在初始化列表中初始化
         state: state ?? TaskMenuState(),
       );

  factory TaskMenu.fromJson(Map<String, dynamic> json) =>
      _$TaskMenuFromJson(json);
  Map<String, dynamic> toJson() => _$TaskMenuToJson(this);

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
