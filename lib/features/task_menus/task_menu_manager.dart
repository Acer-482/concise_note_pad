import 'dart:convert';

import 'package:concise_note_pad/core/utils/config_helper.dart';
import 'package:concise_note_pad/features/task_filters/enums/match_modes/boolean_match_mode.dart';
import 'package:concise_note_pad/features/task_filters/models/composite_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/field_filters/boolean_task_filter.dart';
import 'package:concise_note_pad/features/task_menus/models/task_menu_state.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/features/task_menus/models/task_menu.dart';
import 'package:flutter/material.dart';

/// 任务菜单管理器 - 单例模式类
///
/// 管理所有的任务菜单项
///
/// 提供配置文件保存、读取操作
class TaskMenuManager extends ChangeNotifier {
  // 静态常量 //
  static const String configName = 'task_menu_configs.json';
  // 单例 //
  static final TaskMenuManager _instance = TaskMenuManager._internal();
  static TaskMenuManager get instance => _instance; // 获取单例类
  /// 单例构造
  TaskMenuManager._internal() {
    _init();
  }

  final ConfigHelper _config = ConfigHelper(); // 配置文件
  final List<TaskMenu> _taskMenuList = []; // 任务菜单栏列表
  List<TaskMenu> get taskMenuList => _taskMenuList; // 获取任务菜单列表

  /// 初始化
  Future<void> _init() async {
    await _config.init(configName);
    // 加载任务菜单项列表 //
    final loadSuccessful = await load();
    if (!loadSuccessful) {
      _taskMenuList.addAll([
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
          isPinned: true,
        ),
      ]); // 设置默认值
      save(); // 保存
    }
    update(); // 更新
  }

  /// 从Json列表设置
  void setFromJsonList(List<dynamic> list) {
    // 反序列化 //
    List<TaskMenu> complexList = list
        .cast<Map<String, dynamic>>()
        .map((map) => TaskMenu.fromJson(map))
        .toList();
    // 保存数据 //
    _taskMenuList.clear();
    _taskMenuList.addAll(complexList);
  }

  /// 从Json设置
  void fromJson(String jsonData) {
    setFromJsonList(JsonDecoder().convert(jsonData) as List<dynamic>);
  }

  /// 转为Json
  List<Map<String, dynamic>> toJson() {
    return _taskMenuList.map((complex) => complex.toJson()).toList();
  }

  /// 保存
  Future<bool> save() async =>
      await _config.save(() => JsonEncoder.withIndent('\t').convert(toJson()));

  /// 加载
  Future<bool> load() async => await _config.load(fromJson);

  /// 更新
  void update() {
    MainApp.logInf('TaskMenuManager 更新');
    for (var taskMenu in _taskMenuList) {
      taskMenu.state.update();
    } // 更新状态
    notifyListeners(); // 通知监听者
  }

  /// 构建为滚动浏览器
  CustomScrollView buildScrollView() {
    // 构建复合薄片列表 //
    List<Widget> slivers = [];
    for (TaskMenu complex in _taskMenuList) {
      complex.buildToSliverList(slivers);
    }
    // 构建返回滚动浏览器 //
    return CustomScrollView(slivers: slivers);
  }

  /// 销毁释放
  @override
  void dispose() {
    _taskMenuList.map((complex) => complex.dispose()); // 销毁释放
    super.dispose();
  }
}
