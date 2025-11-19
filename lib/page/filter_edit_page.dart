import 'package:concise_note_pad/filter/composite_filter.dart';
import 'package:flutter/material.dart';

class FilterEditPage extends StatefulWidget {
  final CompositeFilter filter;

  const FilterEditPage({super.key, required this.filter});

  @override
  State<StatefulWidget> createState() => _FilterEditPageState();
}

class _FilterEditPageState extends State<FilterEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('编辑过滤器')));
  }
}
