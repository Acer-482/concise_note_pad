import 'dart:async';

import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/task_menus/task_menu_manager.dart';
import 'package:concise_note_pad/features/tasks/widgets/pages/task_select_list.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 任务主页面
///
/// 用于管理所有任务项
///
/// 显示、添加、删除、更改...等等。
class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    TaskMenuManager.instance.addListener(() => setState(_update));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Scaffold(
          body: TaskMenuManager.instance.buildScrollView(),
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

  // 更新页面
  void _update() {
    setState(() {});
  }

  // 显示选择任务类型页面
  Future<T?> _showSelectTaskType<T>() {
    return PageUtils.showDefaultModalBottomSheet(
      context,
      title: '选择任务类型',
      child: const TaskSelectList(),
    );
  }

  @override
  void dispose() {
    TaskMenuManager.instance.removeListener(_update);
    super.dispose();
  }
}
