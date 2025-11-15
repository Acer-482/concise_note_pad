import 'dart:convert';

import 'package:concise_note_pad/config_utils.dart';
import 'package:concise_note_pad/main.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex.dart';
import 'package:flutter/material.dart';

/// 薄片复合管理器
///
/// 管理所有的薄片复合项
/// 提供配置文件保存写入操作
class SliverComplexManager {
  final List<SliverComplex> sliverComplexList = [];

  /// 初始化
  Future<Null> init() async {
    // 加载薄片复合项列表 //
    final loadSuccessful = await load();
    if (!loadSuccessful) {
      sliverComplexList.addAll([
        SliverComplex(icon: const Icon(Icons.list_alt_rounded), title: '未完成项'),
        SliverComplex(
          icon: const Icon(Icons.list_alt_rounded),
          title: '所有项',
          pinned: true,
        ),
      ]); // 设置默认值
      save(); // 保存
    }
    // 添加监听器 //
    for (var complex in sliverComplexList) {
      complex.state.addListener(save);
    }
  }

  /// 保存
  Future<bool> save() async {
    try {
      final file = await ConfigUtils.getConfig('sliverComplexs.json');
      MainApp.logInf('保存薄片复合列表中...');
      // 序列化 //
      List<Map<String, dynamic>> data = sliverComplexList
          .map((complex) => complex.toMap())
          .toList();
      String jsonData = JsonEncoder.withIndent('\t').convert(data);
      // 保存数据 //
      await file.writeAsString(jsonData);
      MainApp.logInf('保存成功');
      return true;
    } catch (e) {
      MainApp.logWar('保存薄片复合列表失败：$e');
      return false;
    }
  }

  /// 加载
  Future<bool> load() async {
    try {
      final file = await ConfigUtils.getConfig('sliverComplexs.json');
      MainApp.logInf('加载薄片复合列表中...');
      // 加载数据 //
      String jsonData = await file.readAsString();
      // 反序列化 //
      List<Map<String, dynamic>> data =
          (JsonDecoder().convert(jsonData) as List<dynamic>)
              .cast<Map<String, dynamic>>();
      List<SliverComplex> complexList = data
          .map((map) => SliverComplex.fromMap(map))
          .toList();
      // 保存数据 //
      sliverComplexList.clear();
      sliverComplexList.addAll(complexList);
      MainApp.logInf('加载成功');
      return true;
    } catch (e) {
      MainApp.logWar('加载薄片复合列表失败：$e');
      return false;
    }
  }

  /// 更新
  void update() {
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
      complex.state.removeListener(save);
    } // 删除监听器
    sliverComplexList.map((complex) => complex.dispose()); // 销毁释放
  }
}
