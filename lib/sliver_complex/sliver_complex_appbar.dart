import 'package:concise_note_pad/page_utils.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:concise_note_pad/sliver_complex/sort_option_menu.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';

/// 薄片复合应用栏
class SliverComplexAppbar extends StatelessWidget {
  final Icon? icon; // 图标
  final String title; // 标题
  final bool pinned; // 固定在顶部
  final SliverComplexState state; // 状态

  SliverComplexAppbar({
    super.key,
    this.icon,
    this.title = '',
    this.pinned = false,
    SliverComplexState? state,
  }) : state = state ?? SliverComplexState();

  // 显示过滤器设置
  Future<Null> _showFilterOption(BuildContext context) =>
      PageUtils.showDefaultModalBottomSheet(
        context,
        title: '过滤器设置',
        children: [Text('仍在开发中...')],
      );

  // 显示排序设置
  Future<Null> _showSortOption(BuildContext context) =>
      PageUtils.showDefaultModalBottomSheet(
        context,
        children: [SortOptionMenu(state: state)],
      );

  // 显示视图设置
  Future<Null> _showViewOption(BuildContext context) =>
      PageUtils.showDefaultModalBottomSheet(
        context,
        title: '视图设置',
        children: [Text('仍在开发中...')],
      );

  // 构建 选项按钮
  List<Widget> _buildActions(BuildContext context) => [
    IconButton(
      onPressed: () => TaskManager.instance.update(),
      tooltip: '刷新',
      icon: const Icon(Icons.refresh),
    ),
    IconButton(
      onPressed: () => _showFilterOption(context),
      tooltip: '过滤器',
      icon: const Icon(Icons.filter_list),
    ),
    IconButton(
      onPressed: () => _showSortOption(context),
      tooltip: '排序方式',
      icon: const Icon(Icons.sort_rounded),
    ),
    IconButton(
      onPressed: () => _showViewOption(context),
      tooltip: '切换视图',
      icon: Icon(Icons.view_list),
    ),
    PopupMenuButton(
      tooltip: '更多设置',
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.file_download), Text('导出')],
          ),
          onTap: () {},
        ), // 导出
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.file_open_rounded), Text('导入')],
          ),
          onTap: () {},
        ), // 导出
      ],
    ),
  ];

  /// 构建列表项
  @override
  Widget build(BuildContext context) => SliverAppBar(
    leading: icon, // 图标
    title: Text(title),
    pinned: pinned, // 固定在顶部
    actions: _buildActions(context), // 显示选项
  );
}
