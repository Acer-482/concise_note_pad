import 'package:concise_note_pad/filter/composite_filter.dart';
import 'package:concise_note_pad/page/filter_edit_page.dart';
import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:concise_note_pad/util/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

/// 过滤器编辑菜单
class FilterEditMenu extends StatefulWidget {
  const FilterEditMenu({super.key});

  @override
  State<StatefulWidget> createState() => _FilterEditMenuState();
}

class _FilterEditMenuState extends State<FilterEditMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SliverComplexState>(
      builder: (context, state, child) => _buildFilterList(state),
    );
  }

  // 构建过滤器列表
  Widget _buildFilterList(SliverComplexState state) {
    if (state.compositeFilter != null) {
      return Column(
        spacing: 4,
        children:
            [
              ListTile(
                title: Text(state.compositeFilter!.displayName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    IconButton(
                      onPressed: () => _showFilterEditPage(state),
                      tooltip: '编辑',
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => _showDeleteConfirmDialog(state),
                      tooltip: '删除',
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Divider(),
            ] +
            state.compositeFilter!.filterList
                .map((e) => ListTile(title: Text(e.displayName)))
                .toList(),
      );
    } else {
      return Column(
        spacing: 20,
        children: [
          Divider(),
          Text('暂无过滤器', style: Theme.of(context).textTheme.titleMedium),
          ElevatedButton.icon(
            onPressed: () => setState(() {
              state.compositeFilter = CompositeFilter(); // 创建过滤器
              ToastUtils.showStandardToast(
                context,
                msg: '创建成功',
                type: ToastificationType.success,
              );
              state.update(); // 更新
            }),
            icon: const Icon(Icons.add),
            label: Text('点击创建过滤器'),
          ),
        ],
      );
    }
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog(SliverComplexState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认删除？'),
        content: Text('这将会删除整个复合过滤器以及其存储的所有过滤器！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              state.compositeFilter = null; // 清空
              state.update(); // 更新
              ToastUtils.showStandardToast(
                context,
                msg: '删除成功',
                type: ToastificationType.success,
              );
              Navigator.pop(context); // 返回上一页
            },
            child: const Text('确定', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // 显示编辑页面
  Future<void> _showFilterEditPage(SliverComplexState state) async {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => FilterEditPage(filter: state.compositeFilter!),
      ),
    );
  }
}
