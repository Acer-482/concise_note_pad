import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:flutter/material.dart';

/// 任务项表单数据
abstract class TaskItemFormData {
  void Function()? update; // 更新回调 通过此成员调用外部更新方法
  final TextEditingController titleController =
      TextEditingController(); // 文本输入控制器 标题
  final TextEditingController subTitleController =
      TextEditingController(); // 文本输入控制器 小标题
  final TextEditingController detailsController =
      TextEditingController(); // 文本输入控制器 内容
  bool isEnabled = true; // 启用
  TaskItem? editingTaskItem; // 编辑对象（忽略比较）
  final GlobalKey<FormState> _formKeys = GlobalKey(); // 表单控制器

  String get title => titleController.text; // 获取标题
  String get subTitle => subTitleController.text; // 获取副标题
  String get details => detailsController.text; // 获取详情

  TaskItemFormData({this.update, this.editingTaskItem});

  /// 从任务项初始化表单数据
  /// 子类重写是需要将传入类型转换后手动传递数据
  @mustCallSuper
  void initFromItem(TaskItem taskItem) {
    titleController.text = taskItem.title;
    subTitleController.text = taskItem.subTitle;
    detailsController.text = taskItem.details;
    isEnabled = taskItem.isEnabled;
  }

  /// 更新到任务项
  /// 子类重写是需要将传入类型转换后手动传递数据
  @mustCallSuper
  void updateItem(TaskItem taskItem) {
    taskItem.title = title;
    taskItem.subTitle = subTitle;
    taskItem.details = details;
    taskItem.isEnabled = isEnabled;
  }

  /// 构建表单容器
  Widget buildFormWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildForms(context),
    );
  }

  /// 构建更多项表单容器
  Widget buildMoreFormWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildMoreForms(context),
    );
  }

  /// 构建表单
  @mustCallSuper
  List<Widget> buildForms(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return [
      Form(
        key: _formKeys,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                icon: Icon(Icons.title_rounded),
                label: Text(loc.title),
              ),
              validator: (v) => _validateTitle(context, v),
            ),
            TextFormField(
              controller: subTitleController,
              decoration: InputDecoration(
                icon: Icon(Icons.subtitles),
                label: Text(loc.subTitle),
              ),
            ), // 小标题
            SizedBox(height: 8),
            TextFormField(
              controller: detailsController,
              minLines: 1,
              maxLines: 8,
              decoration: InputDecoration(
                icon: Icon(Icons.info),
                label: Text(loc.detailedInformation),
              ),
            ), // 内容
          ],
        ),
      ),
    ];
  }

  /// 构建更多项表单
  @mustCallSuper
  List<Widget> buildMoreForms(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return [
      SwitchListTile(
        value: isEnabled,
        title: Text(loc.isEnabled),
        onChanged: (value) {
          isEnabled = value;
          update?.call();
        },
      ),
    ];
  }

  /// 创建为任务项
  TaskItem toItem();

  /// 验证表单是否有效
  String? _validateTitle(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    if (value == null || value.isEmpty) return loc.titleCannotBeEmpty;
    // 非覆盖模式
    if (editingTaskItem != null
        ? TaskManager.instance.containTitleWithout(value, editingTaskItem!)
        : TaskManager.instance.containTitle(value)) {
      return loc.titleCannotDuplicate;
    }
    return null; // 通过
  }

  /// 验证表单是否有效
  @mustCallSuper
  bool validate() {
    return _formKeys.currentState!.validate();
  }

  /// 释放表单数据
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    detailsController.dispose();
  }
}
