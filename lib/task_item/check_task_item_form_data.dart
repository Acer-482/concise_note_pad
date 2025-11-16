import 'package:concise_note_pad/importance_enumeration/important_level.dart';
import 'package:concise_note_pad/importance_enumeration/important_type.dart';
import 'package:concise_note_pad/task_item/check_task_item.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:concise_note_pad/task_item/task_item_form_data.dart';
import 'package:flutter/material.dart';

/// 可完成任务项表单数据
class CompletableTaskItemFormData extends TaskItemFormData {
  bool isFinished = false; // 已完成
  ImportanceLevel importanceLevel = ImportanceLevel.defaultValue; // 重要程度
  ImportanceType importanceType = ImportanceType.defaultValue; // 重要性类型

  CompletableTaskItemFormData({super.update});

  @override
  void initFromItem(TaskItem taskItem) {
    super.initFromItem(taskItem);
    if (taskItem case CompletableTaskItem checkTaskItem) {
      isFinished = checkTaskItem.isChecked;
      importanceLevel = checkTaskItem.importanceLevel;
      importanceType = checkTaskItem.importanceType;
    } else {
      throw TypeError();
    }
  }

  @override
  void updateItem(TaskItem taskItem) {
    super.updateItem(taskItem);
    if (taskItem case CompletableTaskItem checkTaskItem) {
      checkTaskItem.isChecked = isFinished;
      checkTaskItem.importanceLevel = importanceLevel;
      checkTaskItem.importanceType = importanceType;
    } else {
      throw TypeError();
    }
  }

  @override
  List<Widget> buildForms(BuildContext context) {
    final superForms = super.buildForms(context);
    superForms.addAll([
      ListTile(
        title: Text('重要程度'),
        trailing: DropdownButton(
          items: ImportanceLevel.values
              .map(
                (importance) => DropdownMenuItem(
                  value: importance,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(importance.icon, color: importance.color),
                      Text(importance.displayName),
                    ],
                  ),
                ),
              )
              .toList(),
          value: importanceLevel, // 当前选项
          onChanged: (ImportanceLevel? type) {
            importanceLevel = type ?? ImportanceLevel.defaultValue;
            update?.call(); // 更新
          },
        ),
      ), // 重要程度
      ListTile(
        title: Text('重要性类型'),
        trailing: DropdownButton(
          items: ImportanceType.values
              .map(
                (importance) => DropdownMenuItem(
                  value: importance,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(importance.icon, color: importance.color),
                      Text(importance.displayName),
                    ],
                  ),
                ),
              )
              .toList(),
          value: importanceType, // 当前选项
          onChanged: (ImportanceType? type) {
            importanceType = type ?? ImportanceType.defaultValue;
            update?.call(); // 更新
          },
        ),
      ), // 重要性类型
    ]);
    return superForms;
  }

  @override
  List<Widget> buildMoreForms(BuildContext context) {
    final superWidgets = super.buildMoreForms(context);
    superWidgets.add(
      SwitchListTile(
        value: isFinished,
        title: Text('是否完成'),
        onChanged: (value) {
          isFinished = value;
          update?.call();
        },
      ),
    );
    return superWidgets;
  }

  @override
  TaskItem toItem() {
    final item = CompletableTaskItem(
      title: super.title,
      subTitle: super.subTitle,
      details: super.details,
      isEnabled: super.isEnabled,
      isChecked: isFinished,
      importanceLevel: importanceLevel,
      importanceType: importanceType,
    );
    return item;
  }
}
