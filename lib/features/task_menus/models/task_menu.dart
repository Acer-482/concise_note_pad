import 'package:concise_note_pad/core/converters/icon_data_converter.dart';
import 'package:concise_note_pad/features/task_menus/widgets/task_menu_appbar.dart';
import 'package:concise_note_pad/features/task_menus/widgets/task_menu_list.dart';
import 'package:concise_note_pad/features/task_menus/models/task_menu_state.dart';
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

  /// 图标数据
  @JsonKey()
  @IconDataConverter()
  IconData? iconData;

  /// 标题
  @JsonKey()
  String title;

  /// 固定标题栏
  @JsonKey()
  bool isPinned;

  TaskMenu({TaskMenuState? state, this.iconData, String? title, bool? isPinned})
    : state = state ?? TaskMenuState(),
      title = title ?? '',
      isPinned = isPinned ?? false;

  factory TaskMenu.fromJson(Map<String, dynamic> json) =>
      _$TaskMenuFromJson(json);
  Map<String, dynamic> toJson() => _$TaskMenuToJson(this);

  /// 构建到组件列表
  void buildToSliverList(List<dynamic> l) {
    l.add(
      TaskMenuAppbar(
        iconData: iconData,
        title: title,
        pinned: isPinned,
        taskMenu: this,
      ),
    );
    l.add(TaskMenuList(state: state));
  }

  /// 销毁
  void dispose() {
    state.dispose();
  }
}
