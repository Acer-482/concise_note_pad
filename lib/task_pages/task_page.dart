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
  bool isSortOptionAutoClose = true; // 排序页面自动关闭

  @override
  void initState() {
    super.initState();
    slidableController = SlidableController(this);
  }

  /// 显示自定义模态底部表
  Future<T?> _showCustomModalBottomSheet<T>({
    String? title,
    required List<Widget> children,
  }) {
    return showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => Card(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children:
                <Widget>[
                  if (title != null)
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ), // 标题
                ] +
                children, // 内容
          ),
        ),
      ),
    ); // 显示模态底部表
  }

  // 显示过滤器设置
  Future<Null> _showFilterOption() {
    // 弹出表单选择
    return _showCustomModalBottomSheet(title: '过滤器设置 仍在开发中...', children: []);
  }

  // 显示排序设置
  Future<Null> _showSortOption() {
    final TaskManager taskManager = TaskManager.instance;
    // 弹出表单选择
    return _showCustomModalBottomSheet(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(20, 4, 20, 4),
                  child: Column(
                    spacing: 4, // 间距
                    children: [
                      Row(
                        children: [
                          Text('排序方式：'),
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
                          ),
                        ],
                      ), // 排序方式选择
                      Row(
                        children: [
                          Text('排序完成项置于底层：'),
                          Checkbox(
                            value: taskManager.isPlaceBottomCheckedItem,
                            onChanged: (v) => setState(
                              () => taskManager.isPlaceBottomCheckedItem = v!,
                            ),
                          ),
                        ],
                      ), // 完成项目置底
                      Row(
                        children: [
                          Text('选择类型后自动关闭当前页'),
                          Checkbox(
                            value: isSortOptionAutoClose,
                            onChanged: (v) =>
                                setState(() => isSortOptionAutoClose = v!),
                          ),
                        ],
                      ), // 自动关闭
                    ],
                  ),
                ),
                RadioGroup<SortOption>(
                  groupValue: taskManager.sortOption,
                  onChanged: (SortOption? value) {
                    if (value != null) {
                      // 更新状态 //
                      setState(() {
                        taskManager.sortOption = value; // 设置选项
                        taskManager.update(); // 更新
                      });
                      // 自动延迟关闭 //
                      if (isSortOptionAutoClose) {
                        Timer(Duration(milliseconds: 300), () {
                          if (mounted) Navigator.of(context).pop();
                        });
                      }
                    }
                  },
                  child: Column(
                    children: [
                      RadioListTile<SortOption>(
                        value: SortOption.importance,
                        title: Text('按照重要程度排序'),
                        secondary: Icon(Icons.warning),
                      ),
                      RadioListTile<SortOption>(
                        value: SortOption.name,
                        title: Text('按照名称排序'),
                        secondary: Icon(Icons.abc),
                      ),
                      RadioListTile<SortOption>(
                        value: SortOption.updateDate,
                        title: Text('按照最后修改日期排序'),
                        secondary: Icon(Icons.update),
                      ),
                      RadioListTile<SortOption>(
                        value: SortOption.date,
                        title: Text('按照创建日期排序'),
                        secondary: Icon(Icons.date_range_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // 显示视图设置
  Future<Null> _showViewOption() {
    // 弹出表单选择
    return _showCustomModalBottomSheet(title: '视图设置 仍在开发中...', children: []);
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
        IconButton(
          onPressed: () => _showFilterOption(),
          tooltip: '过滤器',
          icon: const Icon(Icons.filter_list),
        ),
        IconButton(
          onPressed: () => _showSortOption(),
          tooltip: '排序方式',
          icon: const Icon(Icons.sort_rounded),
        ),
        IconButton(
          onPressed: () => _showViewOption(),
          tooltip: '切换视图',
          icon: Icon(Icons.view_list),
        ),
        PopupMenuButton(tooltip: '更多设置', itemBuilder: (context) => [
          ],
        ),
      ], // 选项
    );
  }

  // 显示选择任务类型页面
  Future<T?> _showSelectTaskType<T>() {
    return _showCustomModalBottomSheet(
      title: '选择任务类型',
      children: [Expanded(child: TaskSelectList())],
    );
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
                  (context, index) => taskManager
                      .taskAt(index)
                      .buildListTileCard(context, index),
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
