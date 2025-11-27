import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/task_menus/models/task_menu.dart';
import 'package:concise_note_pad/features/task_menus/task_menu_manager.dart';
import 'package:concise_note_pad/features/task_menus/widgets/pages/task_menu_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

/// 任务菜单管理页面
class TaskMenuSettingPage extends StatefulWidget {
  const TaskMenuSettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskMenuSettingPageState();
}

class _TaskMenuSettingPageState extends State<TaskMenuSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  // 构建页面主题
  Widget? _buildBody() {
    return CustomScrollView(slivers: [_buildAppbar(), _buildList()]);
  }

  // 构建应用栏
  Widget _buildAppbar() {
    return SliverAppBar(
      title: const Text('任务菜单管理'),
      actions: [
        IconButton(onPressed: _addTaskMenu, icon: const Icon(Icons.add)),
      ],
    );
  }

  // 构建列表
  Widget _buildList() {
    return ReorderableSliverList(
      delegate: ReorderableSliverChildListDelegate(
        TaskMenuManager.instance.taskMenuList
            .map(
              (item) => ListTile(
                leading: Icon(item.iconData),
                key: ValueKey(item.title),
                title: Text(item.title),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editTaskMenu(item),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever, color: Colors.red),
                      onPressed: () => PageUtils.showDeleteConfirmDialog(
                        context,
                        contentMessage: '确认删除此任务菜单吗？\n此操作无法撤销！',
                        confirmFunc: () => _removeTaskMenu(item),
                      ),
                    ),
                  ],
                ), // 删除按钮
              ),
            )
            .toList(),
      ),
      onReorder: _onReorder,
    );
  }

  // 页面重新排序回调
  void _onReorder(int oldIndex, int newIndex) {
    final taskMenuList = TaskMenuManager.instance.taskMenuList;
    setState(() {
      taskMenuList.insert(newIndex, taskMenuList.removeAt(oldIndex)); // 调整位置
      TaskMenuManager.instance.update(); // 更新
    });
  }

  // 新建任务项
  void _addTaskMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TaskMenuEditPage()),
    );
  }

  // 编辑任务项
  void _editTaskMenu(TaskMenu menu) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskMenuEditPage(taskMenu: menu)),
    );
  }

  // 删除任务项
  void _removeTaskMenu(TaskMenu menu) {
    TaskMenuManager.instance.taskMenuList.remove(menu); // 调整位置
    TaskMenuManager.instance.update(); // 更新
    setState(() {});
  }
}
