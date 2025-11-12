import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';

// 任务项表单数据 //
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
    return [
      Form(
        key: _formKeys,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                icon: Icon(Icons.title_rounded),
                label: Text('标题'),
              ),
              validator: _validateTitle,
            ),
            TextFormField(
              controller: subTitleController,
              decoration: InputDecoration(
                icon: Icon(Icons.subtitles),
                label: Text('副标题'),
              ),
            ), // 小标题
            SizedBox(height: 8),
            TextFormField(
              controller: detailsController,
              minLines: 1,
              maxLines: 8,
              decoration: InputDecoration(
                icon: Icon(Icons.info),
                label: Text('详细信息'),
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
    return [
      SwitchListTile(
        value: isEnabled,
        title: Text('是否启用'),
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
  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) return '标题不可为空';
    // 非覆盖模式
    if (editingTaskItem != null ? TaskManager.instance.containTitleWithout(value, editingTaskItem!) : TaskManager.instance.containTitle(value)) {
      return '标题不可与现有项重复';
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
