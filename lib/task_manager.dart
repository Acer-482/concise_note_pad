import 'dart:convert';

import 'package:concise_note_pad/config_utils.dart';
import 'package:concise_note_pad/importance_enumeration/important_level.dart';
import 'package:concise_note_pad/importance_enumeration/important_type.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/task_item/check_task_item.dart';
import 'package:concise_note_pad/task_item/task_item.dart';
import 'package:flutter/material.dart';

// 排序选项
enum SortOption {
  name, // 名称
  updateDate, // 修改日期
  date, // 创建日期
  importance, // 重要程度
}

// 任务管理器 //
class TaskManager extends ChangeNotifier {
  // 静态常量 //
  static const String taskDataJsonConfig = 'taskData.json'; // 任务项配置Json文件
  static const String taskSettingsJsonConfig =
      'taskSettings.json'; // 任务项设置Json配置文件

  // 单例 //
  static final TaskManager _instance = TaskManager._internal();
  static TaskManager get instance => _instance; // 获取单例类

  /// 单例构造
  TaskManager._internal() {
    _init();
  }

  // 实例 //
  final List<TaskItem> _taskList = []; // 任务列表
  late SortOption sortOption; // 排序设置
  late bool isReverseSort; // 降序

  TaskItem taskAt(int index) => _taskList[index]; // 获取
  List<TaskItem> get taskList => _taskList; // 获取列表

  void _init() {
    // 尝试加载数据 //
    loadTaskJson().then((value) {
      // 加载失败
      if (value != true) {
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
        saveTaskJson();
      } else {
        // 加载成功 //
        notifyListeners(); // 通知监听者更新
      }
    });
    // 尝试加载数据 //
    loadSettings().then((value) {
      // 加载失败
      if (value != true) {
        MainApp.logInf('设置任务配置为默认值...');
        // 设置默认值 //
        sortOption = SortOption.importance; // 排序设置
        isReverseSort = true; // 降序
        // 重新保存 //
        saveSettings();
      } else {
        // 加载成功 //
        notifyListeners(); // 通知监听者更新
      }
    });
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

  /// 添加任务删除 - 通过地址
  void removeTaskItem(TaskItem item) {
    _taskList.remove(item);
    update(); // 更新
  }

  /// 添加任务项 - 通过索引
  void removeTaskItemAt(int index) {
    _taskList.removeAt(index);
    update(); // 更新
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

  /// 排序
  void sort() {
    _taskList.sort((a, b) {
      return switch (sortOption) {
            SortOption.name => a.title.compareTo(b.title),
            SortOption.updateDate => a.updateDateTime.compareTo(
              b.updateDateTime,
            ),
            SortOption.date => a.createDateTime.compareTo(b.createDateTime),
            SortOption.importance => _compareByImportance(a, b),
          } *
          (isReverseSort ? -1 : 1);
    });
  }

  /// 更新 - 更新列表/保存数据/通知监听者更新
  void update() {
    sort();
    notifyListeners(); // 通知监听者更新
    // 保存 //
    saveTaskJson(); // 保存任务数据
    saveSettings(); // 保存配置文件
  }

  /// 保存任务项json
  Future<bool> saveTaskJson() async {
    try {
      final file = await ConfigUtils.getConfig(taskDataJsonConfig); // 获取文件
      MainApp.logInf('保存任务数据${taskList.toString()}到"${file.path}"中...');
      // 序列化 //
      List<Map<String, dynamic>> taskJsonList = _taskList
          .map((taskItem) => taskItem.toJson())
          .toList();
      final taskJson = JsonEncoder.withIndent(
        '\t',
      ).convert(taskJsonList); // 序列化为json（带有优雅的换行和缩进）
      // 写入 //
      file.writeAsStringSync(taskJson);
      MainApp.logInf('保存成功！');
      return true;
    } catch (e) {
      MainApp.logWar('保存失败：$e');
      return false;
    }
  }

  /// 加载任务项json
  Future<bool> loadTaskJson() async {
    try {
      final file = await ConfigUtils.getConfig(taskDataJsonConfig); // 获取文件
      MainApp.logInf('从"${file.path}"加载任务数据中...');
      // 读取 //
      String jsonData = file.readAsStringSync(); // 读取
      // 反序列化 //
      List<Map<String, dynamic>> dataMap =
          (jsonDecode(jsonData) as List<dynamic>)
              .cast<Map<String, dynamic>>(); // jsonDecode返回List<dynamic> 需要转换
      List<TaskItem> data = dataMap
          .map((map) => TaskItem.fromJson(map))
          .toList(); // 反序列化数据内容
      // 保存 //
      _taskList.clear();
      _taskList.addAll(data);
      MainApp.logInf('加载完成！');
      return true;
    } catch (e) {
      MainApp.logWar('加载失败：$e');
      return false;
    }
  }

  /// 保存配置
  Future<bool> saveSettings() async {
    try {
      final file = await ConfigUtils.getConfig(taskSettingsJsonConfig); // 获取文件
      MainApp.logInf('保存配置${taskList.toString()}到"${file.path}"中...');
      // 序列化 //
      Map<String, dynamic> settingsMap = {
        'sortOption': sortOption.index,
        'isReverseSort': isReverseSort,
      };
      final taskJson = JsonEncoder.withIndent(
        '\t',
      ).convert(settingsMap); // 序列化为json（带有优雅的换行和缩进）
      // 写入 //
      file.writeAsStringSync(taskJson);
      MainApp.logInf('保存成功！');
      return true;
    } catch (e) {
      MainApp.logWar('保存失败：$e');
      return false;
    }
  }

  /// 加载配置
  Future<bool> loadSettings() async {
    try {
      final file = await ConfigUtils.getConfig(taskSettingsJsonConfig); // 获取文件
      MainApp.logInf('从"${file.path}"加载配置中...');
      // 读取 //
      String jsonData = file.readAsStringSync(); // 读取
      // 反序列化 //
      Map<String, dynamic> dataMap = jsonDecode(jsonData); // 解码
      // 保存 //
      sortOption = SortOption.values[dataMap['sortOption']];
      isReverseSort = dataMap['isReverseSort'];
      MainApp.logInf('加载完成！');
      return true;
    } catch (e) {
      MainApp.logWar('加载失败：$e');
      return false;
    }
  }

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
