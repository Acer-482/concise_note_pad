import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:concise_note_pad/features/tasks/widgets/pages/task_edit_page.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Scaffold(
      appBar: PageUtils.buildDefaultAppbar(
        context,
        Text(loc.taskInfoTitle(widget.taskItem.title)), // 标题
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: ListView(
          children: widget.taskItem.buildInfoMap(context).entries.map((entry) {
            return PageUtils.buildDefaultTitleFrame(
              context: context,
              title: entry.key,
              childWidget: entry.value,
            );
          }).toList(),
        ), // 构建信息列表
      ),
      floatingActionButton: FloatingActionButton.extended(
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
        tooltip: loc.editTask,
        icon: const Icon(Icons.edit),
        label: Text(loc.editTask),
      ),
    );
  }
}
