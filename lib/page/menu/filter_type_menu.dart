import 'package:concise_note_pad/filter/task_field_filtter.dart';
import 'package:flutter/material.dart';

// 过滤器类型
class _FilterType {
  IconData iconData;
  TaskFieldFiltter Function() filtter;

  _FilterType({required this.iconData, required this.filtter});
}

/// 选择过滤器类型菜单
class FilterTypeMenu extends StatefulWidget {
  const FilterTypeMenu({super.key});

  @override
  State<StatefulWidget> createState() => _FilterTypeMenuState();
}

class _FilterTypeMenuState extends State<FilterTypeMenu> {
  final List<_FilterType> filterTypeList = [];

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
