import 'dart:convert';

import 'package:concise_note_pad/core/utils/config_helper.dart';
import 'package:concise_note_pad/features/tasks/enums/important_level.dart';
import 'package:concise_note_pad/features/tasks/enums/important_type.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/features/tasks/models/completable_task_item.dart';
import 'package:concise_note_pad/features/tasks/models/task_item.dart';
import 'package:flutter/material.dart';

/// 任务管理器 - 单例模式类
///
/// 管理所有的任务项
/// 
/// 提供配置文件保存、读取操作
class TaskManager extends ChangeNotifier {
  // 静态常量 //
  static const String configName = 'task_items.json';

  // 单例 //
  static final TaskManager _instance = TaskManager._internal();
  static TaskManager get instance => _instance; // 获取单例类

  /// 单例构造
  TaskManager._internal() {
    _init();
  }

  // 实例 //
  final ConfigHelper config = ConfigHelper(); // 配置文件
  final List<TaskItem> _taskList = []; // 任务列表

  /// 获取任务（通过索引）
  TaskItem taskAt(int index) => _taskList[index];
  // 获取任务列表
  List<TaskItem> get taskList => _taskList;

  // 初始化
  void _init() async {
    await config.init(configName);
    bool loadSuccessful = await load(); // 尝试加载数据
    // 根据情况设置属性 //
    if (loadSuccessful != true || taskList.isEmpty) {
      MainApp.logInf('设置任务数据为默认值...');
      // 添加默认值
      addTaskItemAll([
        CompletableTaskItem(
          title: '任务标题',
          subTitle: '任务小标题',
          details:
              '这里是任务详情，用于描述该任务\n这是一个可完成任务项，拥有：\n\t复选框 —— 用于标记该任务是否完成\n\t重要等级和重要性类型 —— 使用用于标记该任务的重要性和重要程度',
          importanceLevel: ImportanceLevel.critical,
          importanceType: ImportanceType.importantAndUrgent,
        ),
        CompletableTaskItem(
          title: '示例任务 - 快递',
          subTitle: '记得拿快递',
          details: '回家记得拿快递！！！\n不想再因为忘记导致已经到家了再下去跑一趟QAQ',
          importanceLevel: ImportanceLevel.low,
          importanceType: ImportanceType.importantNotUrgent,
        ),
        CompletableTaskItem(
          title: '示例任务 - 倒垃圾',
          subTitle: '待会下班别忘记倒垃圾！',
          details: '',
          importanceLevel: ImportanceLevel.medium,
          importanceType: ImportanceType.urgentNotImportant,
        ),
        CompletableTaskItem(
          title: '示例任务 - 视频剪辑',
          subTitle: '13月32日回去别忘记剪视频！',
          details: '别忘了！！！',
          importanceLevel: ImportanceLevel.high,
          importanceType: ImportanceType.importantAndUrgent,
        ),
      ]);
      // 重新保存 //
      save();
    } else {
      // 加载成功 //
      notifyListeners(); // 通知监听者更新
    }
    // 尝试加载数据 //
    // loadSettings().then((value) {
    //   // 加载失败
    //   if (value != true) {
    //     MainApp.logInf('设置任务配置为默认值...');
    //     // 重新保存 //
    //     saveSettings();
    //   } else {
    //     // 加载成功 //
    //     notifyListeners(); // 通知监听者更新
    //   }
    // });
  }

  /// 添加任务项
  void addTaskItem(TaskItem item) {
    _taskList.add(item);
    update(); // 更新
  }

  /// 添加多个任务项
  void addTaskItemAll(List<TaskItem> item) {
    _taskList.addAll(item);
    update(); // 更新
  }

  /// 删除任务项 - 通过地址
  void removeTaskItem(TaskItem item) {
    _taskList.remove(item);
    update(); // 更新
  }

  /// 删除任务项 - 通过索引
  void removeTaskItemAt(int index) {
    _taskList.removeAt(index);
    update(); // 更新
  }

  /// 更新 - 更新列表/保存数据/通知监听者更新
  void update() async {
    MainApp.logInf('TaskManager 更新');
    await save(); // 保存任务数据
    notifyListeners(); // 通知监听者更新
  }

  /// 转为Json
  List<Map<String, dynamic>> toJson() {
    return _taskList.map((taskItem) => taskItem.toJson()).toList();
  }

  /// 从Json设置
  void fromJson(String jsonData) {
    setFromJsonList(jsonDecode(jsonData) as List<dynamic>);
  }

  /// 从Json列表设置
  void setFromJsonList(List<dynamic> list) {
    // 反序列化 //
    List<TaskItem> data = list
        .cast<Map<String, dynamic>>()
        .map((map) => TaskItem.fromJson(map))
        .toList(); // 反序列化数据内容
    // 保存 //
    _taskList.clear();
    _taskList.addAll(data);
  }

  /// 保存
  Future<bool> save() async =>
      await config.save(() => JsonEncoder.withIndent('\t').convert(toJson()));

  /// 加载
  Future<bool> load() async => await config.load(fromJson);

  /// 检测任务是否存在
  bool contains(TaskItem taskItem) => _taskList.contains(taskItem);

  // 检测任务是否存在 - 通过标题
  bool containTitle(String title) {
    for (final item in _taskList) {
      if (item.title == title) return true;
    }
    return false;
  }

  // 检测任务是否存在 - 通过标题
  bool containTitleWithout(String title, TaskItem ignoreTaskItem) {
    for (final item in _taskList) {
      if (item != ignoreTaskItem && item.title == title) return true;
    }
    return false;
  }
}
