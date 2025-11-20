import 'dart:async';

import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 排序设置菜单
class SortOptionMenu extends StatefulWidget {
  const SortOptionMenu({super.key});

  @override
  State<StatefulWidget> createState() => _SortOptionMenuState();
}

class _SortOptionMenuState extends State<SortOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SliverComplexState>(
      builder: (context, state, child) => Expanded(
        child: ListView(
          children: [
            _buildSortReverseButton(state),
            _buildAutoCloseCheckBox(state),
            Divider(),
            _buildSortOptionRadioGroup(state),
          ],
        ),
      ),
    );
  }

  /// 构建排序方式按钮
  Widget _buildSortReverseButton(SliverComplexState state) => ListTile(
    title: const Text('排序方式：'),
    trailing: SegmentedButton<bool>(
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
      selected: {state.isReverseSort},
      onSelectionChanged: (Set<bool> newSelection) {
        setState(() {
          state.isReverseSort = newSelection.first;
          state.update(); // 更新状态
        });
      },
      showSelectedIcon: false,
    ),
  );

  /// 构建自动关闭复选框
  Widget _buildAutoCloseCheckBox(SliverComplexState state) => ListTile(
    title: const Text('选择类型后自动关闭当前页'),
    trailing: Checkbox(
      value: state.isSortOptionAutoClose,
      onChanged: (v) {
        setState(() => state.isSortOptionAutoClose = v!);
        state.update(); // 更新状态
      },
    ),
  );

  /// 构建排序设置单选框组
  Widget _buildSortOptionRadioGroup(SliverComplexState state) =>
      RadioGroup<SortOption>(
        groupValue: state.sortOption,
        onChanged: (SortOption? value) {
          if (value != null) {
            // 更新状态 //
            setState(() {
              state.sortOption = value;
              state.update(); // 更新状态
            }); // 设置选项
            // 自动延迟关闭 //
            if (state.isSortOptionAutoClose) {
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
      );
}
