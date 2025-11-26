import 'package:concise_note_pad/features/task_filters/models/composite_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/task_filter.dart';
import 'package:concise_note_pad/features/task_filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/task_filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
import 'package:concise_note_pad/features/task_filters/widgets/menus/task_field_filter_form_menu.dart';
import 'package:concise_note_pad/features/task_filters/widgets/pages/filter_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 选择过滤器类型菜单
class FilterTypeMenu extends StatefulWidget {
  const FilterTypeMenu({super.key});

  @override
  State<StatefulWidget> createState() => _FilterTypeMenuState();
}

class _FilterTypeMenuState extends State<FilterTypeMenu> {
  late final List<TaskFilterRegistration> filterTypeList;
  @override
  void initState() {
    super.initState();
    filterTypeList = TaskFilterRegistry.instance.getAllRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: filterTypeList
            .map(
              (registration) => ListTile(
                leading: Icon(registration.iconData),
                title: Text(registration.displayName),
                subtitle: Text(registration.description),
                trailing: const Icon(Icons.add),
                onTap: () async {
                  if (registration.buildField == null) {
                    final taskFilter = CompositeFilter();
                    await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            FilterFieldEditPage(filter: taskFilter),
                      ),
                    );
                    _popResult(taskFilter);
                  } else {
                    final taskFilter =
                        await PageUtils.showDefaultModalBottomSheet(
                          context,
                          child: TaskFieldFilterFormMenu.add(
                            registration: registration,
                          ),
                        );
                    _popResult(taskFilter);
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }

  /// 返回结果
  void _popResult(TaskFilter? taskFilter) {
    Navigator.pop(context, taskFilter); // 关闭当前页面
  }
}
