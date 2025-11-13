import 'package:concise_note_pad/task_manager.dart';
import 'package:concise_note_pad/task_pages/task_edit_page.dart';
import 'package:concise_note_pad/page_utils.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:flutter/material.dart';

/// 任务项信息页面
/// 
/// 用于显示任务项的详细信息
class TaskItemInfoPage extends StatefulWidget {
  final TaskItem taskItem; // 任务项
  const TaskItemInfoPage({required this.taskItem, super.key});

  @override
  State<StatefulWidget> createState() => _TaskItemInfoPage();
}

class _TaskItemInfoPage extends State<TaskItemInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageUtils.buildDefaultAppbar(
        context,
        Text('"${widget.taskItem.title}"任务信息'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: ListView(
          children: widget.taskItem.buildInfoMap().entries.map((entry) {
            return PageUtils.buildDefaultTitleFrame(
              context: context,
              title: entry.key,
              childWidget: entry.value,
            );
          }).toList(),
        ), // 构建信息列表
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskEditPage.editTask(widget.taskItem),
            ),
          ); // 弹出编辑对话框
          // 更新 //
          TaskManager.instance.update();
          setState(() {});
        },
        tooltip: '编辑该任务',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
