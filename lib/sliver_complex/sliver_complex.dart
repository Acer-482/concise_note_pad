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

  SliverComplex({Icon? icon, String? title, bool? pinned})
    : state = SliverComplexState() {
    appbar = SliverComplexAppbar(
      icon: icon,
      title: title ?? '',
      pinned: pinned ?? false,
      state: state,
    );
    list = SliverComplexList(state: state);
  }

  /// 添加到列表
  void addToList(List<dynamic> l) {
    l.add(appbar);
    l.add(list);
  }
}
