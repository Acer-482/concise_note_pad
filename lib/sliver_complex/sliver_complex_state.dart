import 'package:concise_note_pad/task_item/check_task_item.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';

/// 排序选项
enum SortOption {
  importance, // 重要程度
  name, // 名称
  updateDate, // 修改日期
  date, // 创建日期
}

/// 复合薄片 状态
class SliverComplexState extends ChangeNotifier {
  bool isReverseSort; // 反转排序
  SortOption sortOption; // 排序设置
  bool isSortOptionAutoClose; // 自动关闭排序设置页面
  final List<TaskItem> _taskList = []; // 列表 为TaskManager列表的副本 用于排序

  SliverComplexState({
    this.isReverseSort = true,
    this.sortOption = SortOption.importance,
    this.isSortOptionAutoClose = true,
  }) {
    TaskManager.instance.addListener(update); // 添加监听
  }

  /// 从字典构建
  factory SliverComplexState.fromMap(Map<String, dynamic> map) {
    return SliverComplexState(
      isReverseSort: map['isReverseSort'],
      sortOption: SortOption.values[map['sortOption']],
      isSortOptionAutoClose: map['isSortOptionAutoClose'],
    );
  }

  /// 转为字典
  Map<String, dynamic> toMap() {
    return {
      'isReverseSort': isReverseSort,
      'sortOption': sortOption.index,
      'isSortOptionAutoClose': isSortOptionAutoClose,
    };
  }

  // 比较重要性
  int _compareByImportance(TaskItem a, TaskItem b) {
    if (a is CompletableTaskItem && b is CompletableTaskItem) {
      return (a.weightValue).compareTo(b.weightValue);
    } else if (a is CompletableTaskItem) {
      return 1;
    } else if (b is CompletableTaskItem) {
      return -1;
    } else {
      return 0;
    }
  }

  /// 更新列表
  void updateList() {
    // 浅拷贝 //
    _taskList.clear();
    _taskList.addAll(List.from(TaskManager.instance.taskList));
    // 排序 //
    _taskList.sort((a, b) {
      return switch (sortOption) {
            SortOption.importance => _compareByImportance(a, b),
            SortOption.name => a.title.compareTo(b.title),
            SortOption.updateDate => a.updateDateTime.compareTo(
              b.updateDateTime,
            ),
            SortOption.date => a.createDateTime.compareTo(b.createDateTime),
          } *
          (isReverseSort ? -1 : 1);
    });
  }

  /// 构建索引的列表项
  Widget listAt(BuildContext context, int index) =>
      _taskList[index].buildListTileCard(context, index);

  /// 获取列表项数量
  int get listSize => TaskManager.instance.taskList.length;

  /// 更新
  void update() {
    updateList(); // 更新列表
    notifyListeners(); // 通知更新
  }

  @override
  void dispose() {
    TaskManager.instance.removeListener(update); // 移除监听器
    super.dispose();
  }
}
