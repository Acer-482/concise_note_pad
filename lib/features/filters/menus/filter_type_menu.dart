import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:concise_note_pad/features/filters/menus/filter_edit_menu.dart';
import 'package:concise_note_pad/core/utils/page_utils.dart';
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
                onTap: () {
                  Navigator.pop(context); // 关闭
                  PageUtils.showDefaultModalBottomSheet(
                    context,
                    child: FilterEditMenu(registration: registration),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
