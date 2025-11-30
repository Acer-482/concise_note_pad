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
    return Scaffold(
      appBar: AppBar(title: const Text('管理任务菜单')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.check),
        label: Text('完成'),
      ),
    );
  }

  // 构建页面主体
  Widget? _buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: CustomScrollView(
        slivers: [_buildList(), _buildTip(), _buildBottomBox()],
      ),
    );
  }

  // 构建提示
  Widget _buildTip() {
    return SliverToBoxAdapter(
      child: Text(
        '长按拖动任务项可以调整顺序',
        style: Theme.of(context).textTheme.labelSmall,
        selectionColor: Colors.grey, // 灰色
        textAlign: TextAlign.center, // 居中
      ),
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
                onTap: () => _editTaskMenu(item),
              ),
            )
            .toList(),
      ),
      onReorder: _onReorder,
    );
  }

  // 构建底部选项
  Widget _buildBottomBox() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          ListTile(
            leading: const Icon(Icons.assignment_add),
            title: Text('添加任务'),
            trailing: const Icon(Icons.add),
            onTap: _addTaskMenu,
          ),
        ],
      ),
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
  Future<void> _addTaskMenu() async {
    await showTaskMenuEditPage(context);
    setState(() {});
  }

  // 编辑任务项
  Future<void> _editTaskMenu(TaskMenu menu) async {
    await showTaskMenuEditPage(context, taskMenu: menu);
    setState(() {});
  }

  // 删除任务项
  void _removeTaskMenu(TaskMenu menu) {
    TaskMenuManager.instance.taskMenuList.remove(menu); // 调整位置
    TaskMenuManager.instance.update(); // 更新
    setState(() {});
  }
}
