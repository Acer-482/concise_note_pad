import 'package:concise_note_pad/page_utils.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:concise_note_pad/task_item/task_item_form_data.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';

/// 编辑/新建任务页面
///
/// 允许显示并编辑/新建任务项
class TaskEditPage extends StatefulWidget {
  final String taskName; // 任务名称
  final TaskItem? taskItem; // 任务项
  final TaskItemFormData formData; // 任务表单数据

  // 创建编辑/新建任务页面
  // 当 this.taskItem,
  const TaskEditPage({
    required this.taskName,
    this.taskItem,
    required this.formData,
    super.key,
  });

  // 创建新任务
  // 将不会管理表单生命周期
  factory TaskEditPage.newTask(TaskItemFormData formData, String? taskName) {
    return TaskEditPage(
      taskName: taskName ?? '',
      taskItem: null,
      formData: formData,
    );
  }

  // 编辑任务项
  factory TaskEditPage.editTask(TaskItem taskItem) {
    return TaskEditPage(
      taskName: '"${taskItem.title}"任务',
      taskItem: taskItem,
      formData: taskItem.toFormData(),
    );
  }

  @override
  State<StatefulWidget> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  late final bool isCreateMode; // 创建模式
  bool isBatchCreationMode = false; // 批量创建模式

  @override
  void initState() {
    super.initState();
    // 获取是否为创建模式 //
    isCreateMode = widget.taskItem == null;
    // 更新表单数据状态 //
    final formData = widget.formData;
    formData.editingTaskItem = widget.taskItem; // 设置覆写
    formData.update = () => setState(() {}); // 设置回调
    // 编辑模式 //
    if (!isCreateMode) {
      formData.initFromItem(widget.taskItem!); // 从任务项初始化表单数据
    }
  }

  // 显示更多对话框
  void _showMoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '更多选项',
          style: Theme.of(context).textTheme.titleLarge,
        ), // 标题
        contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10), // 内容 内边距
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('批量创建模式'),
                  Checkbox(
                    value: isBatchCreationMode,
                    onChanged: (value) {
                      setState(() {
                        isBatchCreationMode = value!;
                        this.setState(() {}); // 更新编辑页面
                      }); // 更新对话框
                    },
                  ),
                ],
              ),
            ],
          ),
        ), // 内容 + 动态页面构建器
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageUtils.buildDefaultAppbar(
        context,
        Text('${isCreateMode ? '新建' : '编辑'}${widget.taskName}'),
        actions: isCreateMode
            ? [
                IconButton(
                  onPressed: _showMoreDialog,
                  icon: Icon(Icons.adaptive.more),
                ),
              ] // 更多按钮
            : null,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageUtils.buildDefaultTitleFrame(
                context: context,
                title: '主要选项',
                childWidget: widget.formData.buildFormWidget(context),
              ),
              PageUtils.buildDefaultTitleFrame(
                context: context,
                title: '更多选项',
                childWidget: widget.formData.buildMoreFormWidget(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _submit(),
        tooltip: isCreateMode ? '创建任务' : '保存更改',
        icon: Icon(
          isCreateMode
              ? (isBatchCreationMode ? Icons.add_box : Icons.add)
              : Icons.check,
        ),
        label: Text(
          isCreateMode ? (isBatchCreationMode ? '批量创建' : '创建') : '保存',
        ),
      ), // 完成按钮
    );
  }

  /// 提交
  void _submit() {
    if (!widget.formData.validate()) return; // 验证表单
    TaskItem taskItem;
    if (isCreateMode) {
      // 创建模式
      taskItem = widget.formData.toItem(); // 创建任务项
      TaskManager.instance.addTaskItem(taskItem); // 添加到任务管理器
    } else {
      // 更新模式
      widget.formData.editingTaskItem = null; // 重置覆写
      taskItem = widget.taskItem!; // 设置任务项
      taskItem.updateDateTime = DateTime.now(); // 更新更改时间
      widget.formData.updateItem(taskItem); // 更新任务项
    }
    if (!isBatchCreationMode) Navigator.of(context).pop(); // 返回
  }

  @override
  void dispose() {
    widget.formData.update = null; // 置空回调
    if (!isCreateMode) widget.formData.dispose(); // 编辑模式管理表单生命周期 释放
    super.dispose();
  }
}
