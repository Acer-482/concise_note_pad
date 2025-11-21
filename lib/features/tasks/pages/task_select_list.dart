import 'package:concise_note_pad/features/tasks/pages/task_edit_page.dart';
import 'package:concise_note_pad/features/tasks/models/completable_task_item.dart';
import 'package:concise_note_pad/features/tasks/forms/completable_task_item_form_data.dart';
import 'package:concise_note_pad/features/tasks/forms/task_item_form_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 任务类型
class _TaskType {
  _TaskType({
    required this.name,
    required this.context,
    required this.icon,
    required this.formData,
    required this.itemType,
    required this.formDataType,
  });

  String name; // 任务名称
  String context; // 任务描述
  Icon icon; // 图标
  TaskItemFormData formData; // 表单数据
  Type itemType; // 任务项类型
  Type formDataType; // 表单数据类型
}

/// 选择任务列表组件
class TaskSelectList extends StatefulWidget {
  const TaskSelectList({super.key});
  @override
  State<StatefulWidget> createState() => _TaskSelectListState();
}

class _TaskSelectListState extends State<TaskSelectList> {
  late final List<_TaskType> _taskItemTypeList;

  @override
  void initState() {
    super.initState();
    // 初始化列表
    _taskItemTypeList = [
      _TaskType(
        name: '可完成任务项',
        context: '创建一个可标记完成、分类和优先级的任务项',
        icon: Icon(Icons.view_list_rounded),
        formData: CompletableTaskItemFormData(),
        itemType: CompletableTaskItem,
        formDataType: CompletableTaskItemFormData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _taskItemTypeList.length,
      itemBuilder: (context, index) {
        _TaskType currentTaskType = _taskItemTypeList[index];
        return Card(
          child: ListTile(
            leading: currentTaskType.icon, // 图标
            title: Text(currentTaskType.name), // 标题
            subtitle: Text(currentTaskType.context), // 描述
            trailing: Icon(Icons.add), // 箭头
            onTap: () {
              Navigator.of(context).pop(); // 关闭
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => TaskEditPage.newTask(
                    currentTaskType.formData,
                    currentTaskType.name,
                  ),
                ), // 新建任务
              );
            }, // 进入编辑页面
          ),
        );
      },
    );
  }
}
