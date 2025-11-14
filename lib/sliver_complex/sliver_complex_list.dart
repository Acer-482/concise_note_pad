import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:flutter/material.dart';

/// 薄片复合列表
class SliverComplexList extends StatefulWidget {
  final SliverComplexState state; // 状态

  SliverComplexList({super.key, SliverComplexState? state})
    : state = state ?? SliverComplexState();

  @override
  State<StatefulWidget> createState() => _SliverComplexListState();
}

class _SliverComplexListState extends State<SliverComplexList> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(() => setState(() {})); // 添加监听器更新
  }

  @override
  Widget build(BuildContext context) => SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) => widget.state.listAt(context, index),
      childCount: widget.state.listSize,
    ),
  );
}
