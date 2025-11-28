import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:concise_note_pad/features/task_menus/models/task_menu_state.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// 任务菜单列表
class TaskMenuList extends StatefulWidget {
  final TaskMenuState state; // 状态

  TaskMenuList({super.key, TaskMenuState? state})
    : state = state ?? TaskMenuState();

  @override
  State<StatefulWidget> createState() => _TaskMenuListState();
}

class _TaskMenuListState extends State<TaskMenuList> {
  @override
  Widget build(BuildContext context) => SlidableAutoCloseBehavior(
    child: SliverImplicitlyAnimatedList<TaskItem>(
      items: widget.state.taskList, // 数据列表
      itemBuilder: (context, animation, item, index) {
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: item.buildListTileCard(context),
        ); // 尺寸渐变组件
      }, // 列表项构建器
      areItemsTheSame: (oldItem, newItem) =>
          oldItem.title == newItem.title, // 比较是否相等
    ), // Sliver动画列表组件
  ); // 自动关闭滑动组件 - 防止同时拉开多个Slidable侧边栏

  @override
  void dispose() {
    super.dispose();
  }
}
