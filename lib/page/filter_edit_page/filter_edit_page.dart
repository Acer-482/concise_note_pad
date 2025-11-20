import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:concise_note_pad/filter/composite_filter.dart';
import 'package:concise_note_pad/filter/task_filter.dart';
import 'package:concise_note_pad/util/page_utils.dart';
import 'package:flutter/material.dart';

class FilterEditPage extends StatefulWidget {
  final TaskFilter filter; // 编辑的过滤器

  const FilterEditPage({super.key, required this.filter});

  @override
  State<StatefulWidget> createState() => _FilterEditPageState();
}

class _FilterEditPageState extends State<FilterEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('编辑"${widget.filter.displayName}"')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        tooltip: '确定',
        icon: const Icon(Icons.check),
        label: Text('确定'),
      ),
    );
  }

  // 构架主题
  Widget _buildBody() {
    final List<Widget> children;
    // 检测是否为复合过滤器 //
    if (widget.filter is CompositeFilter) {
      CompositeFilter compositeFilter = widget.filter as CompositeFilter;
      children = [
        _buildCompositeListTile(compositeFilter),
        Divider(),
        Expanded(child: _buildCompositeFilterView(compositeFilter)),
      ];
    } else {
      children = [];
    }
    // 构建 //
    return Column(children: children);
  }

  // 构建复合过滤器列表项
  Widget _buildCompositeListTile(CompositeFilter compositeFilter) {
    return ListTile(
      title: Text('过滤器模式'),
      trailing: SegmentedButton<bool>(
        segments: [
          ButtonSegment(
            value: false,
            icon: Icon(Icons.arrow_drop_up_rounded),
            label: Text('逻辑或'),
          ),
          ButtonSegment(
            value: true,
            icon: Icon(Icons.arrow_drop_down_rounded),
            label: Text('逻辑与'),
          ),
        ],
        selected: {compositeFilter.isAndLogic},
        onSelectionChanged: (Set<bool> newSelection) {
          setState(
            () => compositeFilter.isAndLogic = newSelection.first,
          ); // 更新状态
        },
        showSelectedIcon: false, // 显示选中图标
      ),
    );
  }

  // 构建复合过滤器浏览器
  Widget _buildCompositeFilterView(CompositeFilter compositeFilter) {
    return CustomScrollView(
      slivers: [
        _buildCompositeFilterAppbar(compositeFilter),
        _buildCompositeFilterList(compositeFilter),
      ],
    );
  }

  // 构建复合过滤器应用栏
  Widget _buildCompositeFilterAppbar(CompositeFilter compositeFilter) {
    return SliverAppBar(
      automaticallyImplyLeading: false, // 禁止自动推断
      title: Text(compositeFilter.displayName),
      actions: _buildCompositeFilterAppbarActions(compositeFilter),
    );
  }

  // 构建复合过滤器应用栏按钮
  List<Widget> _buildCompositeFilterAppbarActions(
    CompositeFilter compositeFilter,
  ) {
    return [
      IconButton(onPressed: () {}, tooltip: '添加', icon: const Icon(Icons.add)),
    ];
  }

  // 构建复合过滤器列表
  Widget _buildCompositeFilterList(CompositeFilter compositeFilter) {
    return SliverImplicitlyAnimatedList(
      items: compositeFilter.filterList,
      itemBuilder: (context, animation, item, i) => ListTile(
        title: Text(item.displayName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            IconButton(
              onPressed: () => {},
              tooltip: '编辑',
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => PageUtils.showDeleteConfirmDialog(
                context,
                completedMessage: '删除"${item.displayName}"过滤器成功',
              ),
              tooltip: '删除',
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
      areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
    );
  }
}
