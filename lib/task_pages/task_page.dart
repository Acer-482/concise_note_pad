import 'dart:async';

import 'package:concise_note_pad/page_utils.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex_manager.dart';
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
  late final SlidableController slidableController = SlidableController(
    this,
  ); // 滑动控制器
  final SliverComplexManager sliverComplexManager =
      SliverComplexManager(); // 控制器

  @override
  void initState() {
    super.initState();
    sliverComplexManager.init().then((_) {
      setState(() {});
    }); // 初始化控制器
  }

  // 显示选择任务类型页面
  Future<T?> _showSelectTaskType<T>() {
    return PageUtils.showDefaultModalBottomSheet(
      context,
      title: '选择任务类型',
      children: [TaskSelectList()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Scaffold(
          body: sliverComplexManager.buildScrollView(),
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

  @override
  void dispose() {
    sliverComplexManager.dispose();
    super.dispose();
  }
}
