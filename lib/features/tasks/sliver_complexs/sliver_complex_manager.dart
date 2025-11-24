import 'dart:convert';

import 'package:concise_note_pad/core/utils/config_helper.dart';
import 'package:concise_note_pad/features/filters/enums/match_modes/boolean_match_mode.dart';
import 'package:concise_note_pad/features/filters/models/composite_filter.dart';
import 'package:concise_note_pad/features/filters/models/field_filters/boolean_task_filter.dart';
import 'package:concise_note_pad/features/tasks/sliver_complexs/sliver_complex_state.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/features/tasks/sliver_complexs/sliver_complex.dart';
import 'package:flutter/material.dart';

/// 薄片复合管理器
///
/// 管理所有的薄片复合项
/// 提供配置文件保存写入操作
class SliverComplexManager {
  final ConfigHelper config = ConfigHelper(); // 配置文件
  final List<SliverComplex> sliverComplexList = []; // 薄片复合项列表

  /// 初始化
  Future<Null> init() async {
    await config.init('sliverComplexs.json');
    // 加载薄片复合项列表 //
    final loadSuccessful = await load();
    if (!loadSuccessful) {
      sliverComplexList.addAll([
        SliverComplex(
          state: SliverComplexState(
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
        SliverComplex(
          iconData: Icons.list_alt_rounded,
          title: '所有项',
          pinned: true,
        ),
      ]); // 设置默认值
      save(); // 保存
    }
    // 添加监听器 //
    for (var complex in sliverComplexList) {
      complex.state.update(); // 更新
      complex.state.addListener(update);
    }
  }

  /// 转为Json
  String toJson(JsonEncoder jsonEncoder) {
    return jsonEncoder.convert(
      sliverComplexList.map((complex) => complex.toJson()).toList(),
    );
  }

  /// 保存
  Future<bool> save() async =>
      await config.save(() => toJson(JsonEncoder.withIndent('\t')));

  /// 加载
  Future<bool> load() async => await config.load((jsonData) {
    // 反序列化 //
    List<Map<String, dynamic>> data =
        (JsonDecoder().convert(jsonData) as List<dynamic>)
            .cast<Map<String, dynamic>>();
    List<SliverComplex> complexList = data
        .map((map) => SliverComplex.fromJson(map))
        .toList();
    // 保存数据 //
    sliverComplexList.clear();
    sliverComplexList.addAll(complexList);
  });

  /// 更新
  void update() {
    MainApp.logInf('SliverComplexManager 更新');
    save(); // 保存
  }

  /// 构建滚动浏览器
  CustomScrollView buildScrollView() {
    // 构建复合薄片列表 //
    List<Widget> slivers = [];
    for (SliverComplex complex in sliverComplexList) {
      slivers.add(complex.appbar);
      slivers.add(complex.list);
    }
    // 构建返回滚动浏览器 //
    return CustomScrollView(slivers: slivers);
  }

  /// 销毁释放
  void dispose() {
    for (var complex in sliverComplexList) {
      complex.state.removeListener(update);
    } // 删除监听器
    sliverComplexList.map((complex) => complex.dispose()); // 销毁释放
  }
}
