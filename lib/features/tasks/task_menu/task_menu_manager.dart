import 'dart:convert';

import 'package:concise_note_pad/core/utils/config_helper.dart';
import 'package:concise_note_pad/features/filters/enums/match_modes/boolean_match_mode.dart';
import 'package:concise_note_pad/features/filters/models/composite_filter.dart';
import 'package:concise_note_pad/features/filters/models/field_filters/boolean_task_filter.dart';
import 'package:concise_note_pad/features/tasks/task_menu/task_menu_state.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/features/tasks/task_menu/task_menu.dart';
import 'package:flutter/material.dart';

/// 任务菜单管理器 - 单例模式类
///
/// 管理所有的任务菜单项
///
/// 提供配置文件保存、读取操作
class TaskMenuManager {
  // 单例 //
  static final TaskMenuManager _instance =
      TaskMenuManager._internal();
  static TaskMenuManager get instance => _instance; // 获取单例类
  /// 单例构造
  TaskMenuManager._internal() {
    _init();
  }

  final ConfigHelper _config = ConfigHelper(); // 配置文件
  final List<TaskMenu> taskMenuList = []; // 任务菜单栏列表

  /// 初始化
  Future<void> _init() async {
    await _config.init('taskMenuConfig.json');
    // 加载任务菜单项列表 //
    final loadSuccessful = await load();
    if (!loadSuccessful) {
      taskMenuList.addAll([
        TaskMenu(
          state: TaskMenuState(
            compositeFilter: CompositeFilter(
              filterList: [
                BooleanTaskFilter(
                  field: 'isChecked',
                  mode: BooleanMatchMode.exact,
                  pattern: false,
                ),
              ],
            ),
          ),
          iconData: Icons.list_alt_rounded,
          title: '未完成项',
        ),
        TaskMenu(
          iconData: Icons.list_alt_rounded,
          title: '所有项',
          pinned: true,
        ),
      ]); // 设置默认值
      save(); // 保存
    }
    // 添加监听器 //
    for (var complex in taskMenuList) {
      complex.state.update(); // 更新
      complex.state.addListener(update);
    }
  }

  /// 从Json列表设置
  void setFromJsonList(List<dynamic> list) {
    // 反序列化 //
    List<TaskMenu> complexList = list
        .cast<Map<String, dynamic>>()
        .map((map) => TaskMenu.fromJson(map))
        .toList();
    // 保存数据 //
    taskMenuList.clear();
    taskMenuList.addAll(complexList);
  }

  /// 从Json设置
  void fromJson(String jsonData) {
    setFromJsonList(JsonDecoder().convert(jsonData) as List<dynamic>);
  }

  /// 转为Json
  List<Map<String, dynamic>> toJson() {
    return taskMenuList.map((complex) => complex.toJson()).toList();
  }

  /// 保存
  Future<bool> save() async =>
      await _config.save(() => JsonEncoder.withIndent('\t').convert(toJson()));

  /// 加载
  Future<bool> load() async => await _config.load(fromJson);

  /// 更新
  void update() {
    MainApp.logInf('TaskMenuManager 更新');
    save(); // 保存
  }

  /// 构建为滚动浏览器
  CustomScrollView buildScrollView() {
    // 构建复合薄片列表 //
    List<Widget> slivers = [];
    for (TaskMenu complex in taskMenuList) {
      slivers.add(complex.appbar);
      slivers.add(complex.list);
    }
    // 构建返回滚动浏览器 //
    return CustomScrollView(slivers: slivers);
  }

  /// 销毁释放
  void dispose() {
    for (var complex in taskMenuList) {
      complex.state.removeListener(update);
    } // 删除监听器
    taskMenuList.map((complex) => complex.dispose()); // 销毁释放
  }
}
