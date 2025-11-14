import 'dart:async';

import 'package:concise_note_pad/sliver_complex/sliver_complex.dart';
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
  final List<SliverComplex> sliverComplexList = [
    SliverComplex(icon: const Icon(Icons.list_alt_rounded), title: '未完成项'),
    SliverComplex(
      icon: const Icon(Icons.list_alt_rounded),
      title: '所有项',
      pinned: true,
    ),
  ];

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

  // 显示选择任务类型页面
  Future<T?> _showSelectTaskType<T>() {
    return _showCustomModalBottomSheet(
      title: '选择任务类型',
      children: [Expanded(child: TaskSelectList())],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];
    for (SliverComplex complex in sliverComplexList) {
      slivers.add(complex.appbar);
      slivers.add(complex.list);
    }
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Scaffold(
          body: CustomScrollView(slivers: slivers), // 滚动浏览器
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
