import 'package:concise_note_pad/filter/registry/task_filter_registration.dart';
import 'package:flutter/material.dart';

/// 过滤器编辑菜单
class FilterEditMenu extends StatefulWidget {
  final TaskFilterRegistration registration;

  const FilterEditMenu({super.key, required this.registration});

  @override
  State<StatefulWidget> createState() => _FilterEditMenuState();
}

class _FilterEditMenuState extends State<FilterEditMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          ListTile(title: const Text('字段')),
          ListTile(title: const Text('样板')),
          ElevatedButton(onPressed: () {}, child: const Text('创建')),
        ],
      ),
    );
  }
}
