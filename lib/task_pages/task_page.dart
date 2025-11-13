import 'dart:async';

import 'package:concise_note_pad/task_pages/task_select_list.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

/// 任务页面
/// 
/// 显示、添加、删除、更改、管理任务项
class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late final SlidableController slidableController; // 滑动控制器

  @override
  void initState() {
    super.initState();
    slidableController = SlidableController(this);
  }

  /// 显示自定义模态底部表
  Future<T?> _showCustomModalBottomSheet<T>(
    String title,
    List<Widget> children,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                <Widget>[
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                ] +
                children,
          ),
        ),
      ),
    ); // 显示模态底部表
  }

  /// 构建单选框列表磁贴
  ListTile buildRadioListTile(
    IconData iconData,
    String name,
    SortOption option,
    void Function(void Function()) setState,
  ) => ListTile(
    leading: Icon(iconData),
    title: Text(name),
    trailing: IgnorePointer(child: Radio<SortOption>.adaptive(value: option)),
    onTap: () {
      setState(() {
        TaskManager.instance.sortOption = option; // 排序设置
        debugPrint(TaskManager.instance.sortOption.toString());
      });
      TaskManager.instance.update(); // 更新任务管理器
      // 延迟一段时间返回
      Timer(Duration(milliseconds: 300), () {
        if (mounted) Navigator.of(context).pop(); // 返回
      });
    },
  );

  // 显示过滤器设置
  Future<Null> _showFilterOption() {
    // 弹出表单选择
    return _showCustomModalBottomSheet('过滤器设置 仍在开发中...', []);
  }

  // 显示排序设置
  Future<Null> _showSortOption() {
    final TaskManager taskManager = TaskManager.instance;
    // 弹出表单选择
    return _showCustomModalBottomSheet('排序方式', [
      StatefulBuilder(
        builder: (context, setState) => RadioGroup<SortOption>(
          groupValue: taskManager.sortOption,
          onChanged: (value) {
            setState(() {
              taskManager.sortOption = value!;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: false,
                    icon: Icon(Icons.arrow_drop_up_rounded),
                    label: Text('升序'),
                  ),
                  ButtonSegment(
                    value: true,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    label: Text('降序'),
                  ),
                ],
                selected: {taskManager.isReverseSort},
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() {
                    taskManager.isReverseSort = newSelection.first;
                    taskManager.update(); // 更新任务管理器
                  });
                },
                showSelectedIcon: false,
              ), // 升序降序选择
              buildRadioListTile(
                Icons.abc,
                '按照名称排序',
                SortOption.name,
                setState,
              ),
              buildRadioListTile(
                Icons.update,
                '按照最后修改日期排序',
                SortOption.updateDate,
                setState,
              ),
              buildRadioListTile(
                Icons.date_range_rounded,
                '按照创建日期排序',
                SortOption.date,
                setState,
              ),
              buildRadioListTile(
                Icons.warning,
                '按照重要程度排序',
                SortOption.importance,
                setState,
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  // 显示视图设置
  Future<Null> _showViewOption() {
    // 弹出表单选择
    return _showCustomModalBottomSheet('视图设置 仍在开发中...', []);
  }

  // 构建 应用栏 - 所有任务
  Widget _buildAllTaskSliverAppbar() {
    return SliverAppBar(
      leading: Icon(Icons.list_alt_rounded),
      title: Text('所有任务'),
      pinned: true, // 固定在顶部
      actions: [
        IconButton(
          onPressed: () => TaskManager.instance.update(),
          tooltip: '刷新',
          icon: const Icon(Icons.refresh),
        ),
        PopupMenuButton(
          tooltip: '更多设置',
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.filter_list),
                title: Text('过滤器'),
              ),
              onTap: () {
                _showFilterOption();
              },
            ),
            PopupMenuItem(
              child: ListTile(leading: Icon(Icons.sort), title: Text('排序方式')),
              onTap: () {
                _showSortOption();
              },
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.view_list),
                title: Text('切换视图'),
              ),
              onTap: () {
                _showViewOption();
              },
            ),
          ],
        ),
      ], // 选项
    );
  }

  // 显示选择任务类型页面
  Future<T?> _showSelectTaskType<T>() {
    return _showCustomModalBottomSheet('选择任务类型', [
      Expanded(child: TaskSelectList()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildAllTaskSliverAppbar(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      taskManager.taskAt(index).buildListTileCard(context, index),
                  childCount: taskManager.taskList.length, // 数量
                ),
              ),
            ],
          ), // 滚动浏览器
          floatingActionButton: FloatingActionButton(
            tooltip: '新建任务',
            onPressed: () async {
              await _showSelectTaskType();
              taskManager.update(); // 更新
            },
            child: Icon(Icons.add),
          ), // 新建任务悬浮按钮
        );
      },
    );
  }
}
