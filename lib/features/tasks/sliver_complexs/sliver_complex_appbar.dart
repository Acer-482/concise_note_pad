import 'package:concise_note_pad/features/filters/pages/filter_edit_page.dart';
import 'package:concise_note_pad/features/tasks/menus/export_file_option_menu.dart';
import 'package:concise_note_pad/features/tasks/menus/import_file_option_menu.dart';
import 'package:concise_note_pad/features/tasks/menus/view_option_menu.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/tasks/sliver_complexs/sliver_complex_state.dart';
import 'package:concise_note_pad/features/tasks/menus/sort_option_menu.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 薄片复合应用栏
class SliverComplexAppbar extends StatelessWidget {
  final IconData? iconData; // 图标
  final String title; // 标题
  final bool pinned; // 固定在顶部
  final SliverComplexState state; // 状态

  const SliverComplexAppbar({
    super.key,
    this.iconData,
    this.title = '',
    this.pinned = false,
    required this.state,
  });

  // 显示弹出菜单
  Future<Null> _showPopMenu(
    BuildContext context, {
    String? title,
    EdgeInsetsGeometry? padding,
    required Widget child,
  }) => PageUtils.showDefaultModalBottomSheet(
    context,
    title: title,
    padding: padding,
    child: ChangeNotifierProvider.value(
      value: state,
      child: child,
    ), // 提供ChangeNotifierProvider - 此处调用value构造是为了防止自动调用dispose提前释放state
  );

  // 显示过滤器设置
  Future<Null> _showFilterOption(BuildContext context) => Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => FilterEditPage(filter: state.compositeFilter),
    ),
  );

  // 显示排序设置
  Future<Null> _showSortOption(BuildContext context) => _showPopMenu(
    context,
    padding: EdgeInsets.all(18),
    child: const SortOptionMenu(),
  );

  // 显示视图设置
  Future<Null> _showViewOption(BuildContext context) =>
      _showPopMenu(context, title: '视图设置', child: const ViewOptionMenu());

  // 显示导出设置
  Future<Null> _showExportOption(BuildContext context) =>
      _showPopMenu(context, title: '导出设置', child: const ExportFileOptionMenu());

  // 显示导入设置
  Future<Null> _showImportOption(BuildContext context) =>
      _showPopMenu(context, title: '导入设置', child: const ImportFileOptionMenu());

  // 构建选项按钮
  List<Widget> _buildActions(BuildContext context) => [
    IconButton(
      onPressed: () => TaskManager.instance.update(),
      tooltip: '刷新',
      icon: const Icon(Icons.refresh),
    ),
    PopupMenuButton(
      tooltip: '更多设置',
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.filter_list), Text('过滤器')],
          ),
          onTap: () => _showFilterOption(context),
        ),
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.sort_rounded), Text('排序方式')],
          ),
          onTap: () => _showSortOption(context),
        ),
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.view_list), Text('切换视图')],
          ),
          onTap: () => _showViewOption(context),
        ),
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.file_download), Text('导出')],
          ),
          onTap: () => _showExportOption(context),
        ), // 导出
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.file_open_rounded), Text('导入')],
          ),
          onTap: () => _showImportOption(context),
        ), // 导出
      ],
    ),
  ];

  /// 构建列表项
  @override
  Widget build(BuildContext context) => SliverAppBar(
    leading: Icon(iconData), // 图标
    title: Text(title),
    pinned: pinned, // 固定在顶部
    actions: _buildActions(context), // 显示选项
  );
}
