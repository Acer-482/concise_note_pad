import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:flutter/material.dart';

/// 过滤器设置菜单
class FilterOptionMenu extends StatefulWidget {
  final SliverComplexState state;

  const FilterOptionMenu({super.key, required this.state});

  @override
  State<StatefulWidget> createState() => _FilterOptionMenuState();
}

class _FilterOptionMenuState extends State<FilterOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
      ],
    );
  }
}
