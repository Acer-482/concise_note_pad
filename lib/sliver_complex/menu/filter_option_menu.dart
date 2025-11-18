import 'package:concise_note_pad/sliver_complex/sliver_complex_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 过滤器设置菜单
class FilterOptionMenu extends StatefulWidget {
  const FilterOptionMenu({super.key});

  @override
  State<StatefulWidget> createState() => _FilterOptionMenuState();
}

class _FilterOptionMenuState extends State<FilterOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SliverComplexState>(
      builder: (context, value, child) => Column(
        children: [
          //
        ],
      ),
    );
  }
}
