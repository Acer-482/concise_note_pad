import 'package:concise_note_pad/features/task_filters/widgets/pages/filter_edit_page.dart';
import 'package:concise_note_pad/features/tasks/widgets/menus/export_file_option_menu.dart';
import 'package:concise_note_pad/features/tasks/widgets/menus/import_file_option_menu.dart';
import 'package:concise_note_pad/features/tasks/widgets/menus/view_option_menu.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/task_menus/models/task_menu_state.dart';
import 'package:concise_note_pad/features/tasks/widgets/menus/sort_option_menu.dart';
import 'package:concise_note_pad/features/task_menus/widgets/pages/task_menu_setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 任务菜单应用栏
class TaskMenuAppbar extends StatelessWidget {
  final IconData? iconData; // 图标
  final String title; // 标题
  final bool pinned; // 固定在顶部
  final TaskMenuState state; // 状态

  const TaskMenuAppbar({
    super.key,
    this.iconData,
    this.title = '',
    this.pinned = false,
    required this.state,
  });

  // 显示弹出菜单
  Future<void> _showPopMenu(
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

  // 构建选项按钮
  List<Widget> _buildActions(BuildContext context) => [
    IconButton(
      onPressed: () => state.update(), // 更新状态
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
        ),
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.file_open_rounded), Text('导入')],
          ),
          onTap: () => _showImportOption(context),
        ),
        PopupMenuItem(
          child: Row(
            spacing: 10,
            children: const [Icon(Icons.settings), Text('管理任务菜单')],
          ),
          onTap: () => _showTaskMenuOption(context),
        ), // 导出
      ],
    ),
  ];

  // 显示过滤器设置
  void _showFilterOption(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            FilterFieldEditPage(filter: state.compositeFilter),
      ),
    );
    state.update(); // 更新以保存应用过滤器
  }

  // 显示排序设置
  Future<void> _showSortOption(BuildContext context) => _showPopMenu(
    context,
    padding: EdgeInsets.all(18),
    child: const SortOptionMenu(),
  );

  // 显示视图设置
  Future<void> _showViewOption(BuildContext context) =>
      _showPopMenu(context, title: '视图设置', child: const ViewOptionMenu());

  // 显示导出设置
  Future<void> _showExportOption(BuildContext context) => _showPopMenu(
    context,
    title: '导出设置',
    padding: EdgeInsets.all(10),
    child: const ExportFileOptionMenu(),
  );

  // 显示导入设置
  Future<void> _showImportOption(BuildContext context) =>
      _showPopMenu(context, title: '导入设置', child: const ImportFileOptionMenu());

  // 显示任务菜单设置
  Future<void> _showTaskMenuOption(BuildContext context) => Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => const TaskMenuSettingPage()),
  );

  /// 构建列表项
  @override
  Widget build(BuildContext context) => SliverAppBar(
    leading: Icon(iconData), // 图标
    title: Text(title),
    pinned: pinned, // 固定在顶部
    actions: _buildActions(context), // 显示选项
  );
}
