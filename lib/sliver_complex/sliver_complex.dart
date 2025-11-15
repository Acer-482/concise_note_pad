import 'package:concise_note_pad/sliver_complex/sliver_complex_appbar.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex_list.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:flutter/material.dart';

/// 薄片复合项
///
/// 复合应用栏和列表
class SliverComplex {
  final SliverComplexState state; // 状态
  late final SliverComplexAppbar appbar; // 应用栏
  late final SliverComplexList list; // 列表

  final Icon? icon;
  final String title;
  final bool pinned;

  SliverComplex({
    SliverComplexState? state,
    this.icon,
    String? title,
    bool? pinned,
  }) : state = state ?? SliverComplexState(),
       title = title ?? '',
       pinned = pinned ?? false {
    appbar = SliverComplexAppbar(
      icon: icon,
      title: this.title,
      pinned: this.pinned,
      state: this.state,
    );
    list = SliverComplexList(state: this.state);
  }

  /// 从字典构造
  factory SliverComplex.fromMap(Map<String, dynamic> map) {
    final icon = map['icon'] != null ? Icon(IconData(map['icon'])) : null;
    return SliverComplex(
      state: SliverComplexState.fromMap(map['state']),
      icon: icon,
      title: map['title'],
      pinned: map['pinned'],
    );
  }

  /// 转为字典
  Map<String, dynamic> toMap() {
    return {
      'state': state.toMap(),
      'icon': icon?.icon?.codePoint,
      'title': title,
      'pinned': pinned,
    };
  }

  /// 添加到列表
  void addToList(List<dynamic> l) {
    l.add(appbar);
    l.add(list);
  }

  /// 销毁
  void dispose() {
    state.dispose();
  }
}
