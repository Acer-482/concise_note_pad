import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/features/tasks/enums/important_level.dart';
import 'package:concise_note_pad/features/tasks/enums/important_type.dart';
import 'package:concise_note_pad/features/tasks/forms/completable_task_item_form_data.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:concise_note_pad/features/tasks/forms/task_item_form_data.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completable_task_item.g.dart';

/// 可完成任务项
@JsonSerializable()
class CompletableTaskItem extends TaskItem {
  bool isChecked; // 选中
  ImportanceLevel importanceLevel; // 重要程度
  ImportanceType importanceType; // 重要性类型

  @JsonKey(includeFromJson: true)
  @override
  String get type => 'CompletableTaskItem';

  CompletableTaskItem({
    required super.title,
    super.subTitle = '',
    super.details = '',
    super.isEnabled = true,
    super.createDateTime,
    super.updateDateTime,

    this.isChecked = false,
    ImportanceLevel? importanceLevel,
    ImportanceType? importanceType,
  }) : importanceLevel = importanceLevel ?? ImportanceLevel.defaultValue,
       importanceType = importanceType ?? ImportanceType.defaultValue;

  factory CompletableTaskItem.fromJson(Map<String, dynamic> json) =>
      _$CompletableTaskItemFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    final jsonMap = super.toJson();
    jsonMap.addAll(_$CompletableTaskItemToJson(this));
    return jsonMap;
  }

  @override
  Map<String, Widget> buildInfoMap(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    final superMap = super.buildInfoMap(context);
    superMap[loc.completableTaskItem] = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.importanceWeight(weightValue)),
        Text(
          loc.importanceLevelLabel(importanceLevel.displayName(context)),
          style: TextStyle(color: importanceLevel.color),
        ),
        Text(
          loc.importanceTypeLabel(importanceType.displayName(context)),
          style: TextStyle(color: importanceType.color),
        ),
      ],
    );
    return superMap;
  }

  @override
  TaskItemFormData toFormData() {
    final formData = CompletableTaskItemFormData();
    formData.initFromItem(this);
    return formData;
  }

  @override
  Widget? buildListTileLeading(BuildContext context) {
    return importanceType == ImportanceType.notImportantNotUrgent
        ? super.buildListTileLeading(context)
        : Icon(importanceType.icon, color: importanceType.color);
  }

  @override
  Widget? buildListTileTrailing(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        isChecked = value!;
        TaskManager.instance.update();
      },
    );
  }

  @override
  Color? getLeftHighlightColor() {
    return importanceLevel.color;
  }

  // 获取重要性权重
  int get weightValue =>
      importanceLevel.weightValue + importanceType.weightValue;
}
