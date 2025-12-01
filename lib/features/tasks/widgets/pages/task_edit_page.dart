import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:concise_note_pad/features/tasks/forms/task_item_form_data.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:concise_note_pad/core/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// 编辑/新建任务页面
///
/// 允许显示并编辑/新建任务项
class TaskEditPage extends StatefulWidget {
  final String Function(BuildContext context) taskName; // 任务名称
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
      taskName: (context) => taskName ?? '',
      taskItem: null,
      formData: formData,
    );
  }

  // 编辑任务项
  factory TaskEditPage.editTask(TaskItem taskItem) {
    return TaskEditPage(
      taskName: (context) =>
          AppLocalizations.of(context)!.taskInfoTitle(taskItem.title),
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          loc.moreOptions,
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
                  Text(loc.batchCreationMode),
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
            child: Text(loc.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Scaffold(
      appBar: PageUtils.buildDefaultAppbar(
        context,
        Text(isCreateMode ? loc.newTask : loc.editTask),
        actions: isCreateMode
            ? [
                IconButton(
                  onPressed: _showMoreDialog,
                  icon: Icon(Icons.adaptive.more),
                ),
              ] // 更多按钮
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                loc.mainOptions,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              widget.formData.buildFormWidget(context),
              Divider(),
              Text(
                loc.moreOptions,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              widget.formData.buildMoreFormWidget(context),
              Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _submit(),
        tooltip: isCreateMode ? loc.newTask : loc.editTask,
        icon: Icon(
          isCreateMode
              ? (isBatchCreationMode ? Icons.add_box : Icons.add)
              : Icons.check,
        ),
        label: Text(
          isCreateMode
              ? (isBatchCreationMode ? loc.batchCreate : loc.create)
              : loc.save,
        ),
      ), // 完成按钮
    );
  }

  /// 提交
  void _submit() {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    if (!widget.formData.validate()) return; // 验证表单
    TaskItem taskItem;
    if (isCreateMode) {
      // 创建模式
      taskItem = widget.formData.toItem(); // 创建任务项
      TaskManager.instance.addTaskItem(taskItem); // 添加到任务管理器
      // 输出
      ToastUtils.showStandardToast(
        context,
        title: loc.createComplete,
        msg: loc.taskCreateSuccess(taskItem.title),
        type: ToastificationType.success,
      );
    } else {
      // 更新模式
      widget.formData.editingTaskItem = null; // 重置覆写
      taskItem = widget.taskItem!; // 设置任务项
      taskItem.updateDateTime = DateTime.now(); // 更新更改时间
      widget.formData.updateItem(taskItem); // 更新任务项
      ToastUtils.showStandardToast(
        context,
        title: loc.modifyComplete,
        msg: loc.taskModifySuccess(taskItem.title),
        type: ToastificationType.success,
      );
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
