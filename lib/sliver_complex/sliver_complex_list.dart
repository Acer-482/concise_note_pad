import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// 薄片复合列表
class SliverComplexList extends StatefulWidget {
  final SliverComplexState state; // 状态

  SliverComplexList({super.key, SliverComplexState? state})
    : state = state ?? SliverComplexState();

  @override
  State<StatefulWidget> createState() => _SliverComplexListState();
}

class _SliverComplexListState extends State<SliverComplexList> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(_update); // 添加监听器更新
  }

  /// 更新ui
  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SlidableAutoCloseBehavior(
    child: SliverImplicitlyAnimatedList<TaskItem>(
      items: widget.state.taskList, // 您的数据列表
      areItemsTheSame: (oldItem, newItem) =>
          oldItem.title == newItem.title, // 比较是否相等
      itemBuilder: (context, animation, item, index) {
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: item.buildListTileCard(context),
        );
      },
    ), // Sliver动画列表
  ); // 自动关闭滑动组件

  @override
  void dispose() {
    widget.state.removeListener(_update); // 删除监听器
    super.dispose();
  }
}
