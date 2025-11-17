import 'dart:async';

import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:flutter/material.dart';

/// 排序设置菜单
class SortOptionMenu extends StatefulWidget {
  final SliverComplexState state;

  const SortOptionMenu({super.key, required this.state});

  @override
  State<StatefulWidget> createState() => _SortOptionMenuState();
}

class _SortOptionMenuState extends State<SortOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(20, 4, 20, 4),
          child: Column(
            spacing: 4, // 间距
            children: [
              Row(
                children: [
                  Text('排序方式：'),
                  SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                        value: false,
                        icon: Icon(Icons.arrow_drop_up_rounded),
                        label: Text('升序'),
                      ),
                      ButtonSegment(
                        value: true,
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        label: Text('降序'),
                      ),
                    ],
                    selected: {widget.state.isReverseSort},
                    onSelectionChanged: (Set<bool> newSelection) {
                      setState(() {
                        widget.state.isReverseSort = newSelection.first;
                        widget.state.update(); // 更新状态
                      });
                    },
                    showSelectedIcon: false,
                  ),
                ],
              ), // 排序方式选择
              Row(
                children: [
                  Text('选择类型后自动关闭当前页'),
                  Checkbox(
                    value: widget.state.isSortOptionAutoClose,
                    onChanged: (v) {
                      setState(() => widget.state.isSortOptionAutoClose = v!);
                      widget.state.update(); // 更新状态
                    },
                  ),
                ],
              ), // 自动关闭
            ],
          ),
        ),
        RadioGroup<SortOption>(
          groupValue: widget.state.sortOption,
          onChanged: (SortOption? value) {
            if (value != null) {
              // 更新状态 //
              setState(() {
                widget.state.sortOption = value;
                widget.state.update(); // 更新状态
              }); // 设置选项
              // 自动延迟关闭 //
              if (widget.state.isSortOptionAutoClose) {
                Timer(Duration(milliseconds: 300), () {
                  if (mounted) Navigator.of(context).pop();
                });
              }
            }
          },
          child: Column(
            children: [
              RadioListTile<SortOption>(
                value: SortOption.importance,
                title: Text('按照重要程度排序'),
                secondary: Icon(Icons.warning),
              ),
              RadioListTile<SortOption>(
                value: SortOption.name,
                title: Text('按照名称排序'),
                secondary: Icon(Icons.abc),
              ),
              RadioListTile<SortOption>(
                value: SortOption.updateDate,
                title: Text('按照最后修改日期排序'),
                secondary: Icon(Icons.update),
              ),
              RadioListTile<SortOption>(
                value: SortOption.date,
                title: Text('按照创建日期排序'),
                secondary: Icon(Icons.date_range_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
