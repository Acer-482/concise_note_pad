import 'dart:async';

import 'package:concise_note_pad/core/l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Scaffold(
          body: TaskMenuManager.instance.buildScrollView(),
          floatingActionButton: FloatingActionButton(
            tooltip: loc.newTask,
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return PageUtils.showDefaultModalBottomSheet(
      context,
      title: loc.selectTaskType,
      child: const TaskSelectList(),
    );
  }

  @override
  void dispose() {
    TaskMenuManager.instance.removeListener(_update);
    super.dispose();
  }
}
