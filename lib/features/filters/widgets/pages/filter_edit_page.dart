import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:concise_note_pad/features/filters/models/composite_filter.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filter.dart';
import 'package:concise_note_pad/features/filters/models/task_filter.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/widgets/menus/filter_type_menu.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/filters/widgets/menus/task_field_filter_form_menu.dart';
import 'package:concise_note_pad/features/tasks/models/completable_task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 字段过滤器编辑页面
class FilterFieldEditPage extends StatefulWidget {
  final CompositeFilter filter; // 编辑的过滤器

  const FilterFieldEditPage({super.key, required this.filter});

  @override
  State<StatefulWidget> createState() => _FilterFieldEditPageState();
}

class _FilterFieldEditPageState extends State<FilterFieldEditPage> {
  final CompletableTaskItem _testTaskitem = CompletableTaskItem(title: '临时测试用CompletableTaskItem');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('编辑${widget.filter.displayName}')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.check),
        label: Text('确定并返回'),
      ),
    );
  }

  // 构架主题
  Widget _buildBody() {
    return Column(
      children:
          _buildCompositeListTile(widget.filter) +
          <Widget>[
            Divider(),
            Expanded(child: _buildCompositeFilterView(widget.filter)),
          ],
    );
  }

  // 构建复合过滤器基本列表项
  List<Widget> _buildCompositeListTile(CompositeFilter compositeFilter) {
    return [
      CheckboxListTile(
        value: compositeFilter.isReverse,
        title: Text('反转过滤器'),
        onChanged: (value) =>
            setState(() => compositeFilter.isReverse = value!),
      ), // 反转过滤器
      ListTile(
        title: Text('过滤器模式'),
        trailing: SegmentedButton<bool>(
          segments: [
            ButtonSegment(value: false, label: Text('逻辑或')),
            ButtonSegment(value: true, label: Text('逻辑与')),
          ],
          selected: {compositeFilter.isAndLogic},
          onSelectionChanged: (Set<bool> newSelection) {
            setState(
              () => compositeFilter.isAndLogic = newSelection.first,
            ); // 更新状态
          },
        ),
      ),
    ];
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
      title: const Text('子过滤器'),
      actions: _buildCompositeFilterAppbarActions(compositeFilter),
    );
  }

  // 构建复合过滤器应用栏按钮
  List<Widget> _buildCompositeFilterAppbarActions(
    CompositeFilter compositeFilter,
  ) {
    return [
      IconButton(
        onPressed: _showFilterTypeMenu,
        tooltip: '添加',
        icon: const Icon(Icons.add),
      ),
    ];
  }

  // 构建复合过滤器列表
  Widget _buildCompositeFilterList(CompositeFilter compositeFilter) {
    return SliverImplicitlyAnimatedList<TaskFilter>(
      items: compositeFilter.filterList,
      itemBuilder: (context, animation, filter, i) => ListTile(
        leading: Icon(
          TaskFilterRegistry.instance.getRegistration(filter.type)!.iconData,
        ),
        title: Text(filter.displayName), // 标题
        subtitle: Text(
          filter.stateusInfo,
          style: TextStyle(color: filter.isValid ? null : Colors.red),
        ), // 状态信息
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            IconButton(
              onPressed: () => _editFilter(filter),
              tooltip: '编辑',
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => _removeFilter(compositeFilter, filter),
              tooltip: '删除',
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ), // 选项组
        onTap: () => _editFilter(filter),
      ),
      areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
    );
  }

  /// 选择过滤器类型页面
  void _showFilterTypeMenu() async {
    TaskFilter? filter = await PageUtils.showDefaultModalBottomSheet(
      context,
      child: const FilterTypeMenu(),
    );
    // 判断返回的过滤器是否为空
    if (filter != null) {
      widget.filter.filterList.add(filter); // 添加
      setState(() {}); // 更新状态
    }
  }

  /// 编辑过滤器
  void _editFilter<T>(TaskFilter filter) async {
    if (filter is CompositeFilter) {
      await Navigator.push<T>(
        context,
        CupertinoPageRoute(
          builder: (context) => FilterFieldEditPage(filter: filter),
        ),
      );
      filter.matches(_testTaskitem); // 匹配一次以更新状态
      setState(() {}); // 更新状态
    } else if (filter is TaskFieldFilter) {
      await PageUtils.showDefaultModalBottomSheet(
        context,
        child: TaskFieldFilterFormMenu.edit(filter: filter),
      );
      filter.matches(_testTaskitem); // 匹配一次以更新状态
      setState(() {}); // 更新状态
    } else {
      throw Exception('未知过滤器类型');
    }
  }

  // 删除过滤器
  Future<bool> _removeFilter<T>(
    CompositeFilter compositeFilter,
    TaskFilter filter,
  ) {
    return PageUtils.showDeleteConfirmDialog(
      context,
      completedMessage: '删除"${filter.displayName}"过滤器成功',
      confirmFunc: () =>
          setState(() => compositeFilter.filterList.remove(filter)),
    );
  }
}
