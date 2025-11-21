import 'package:concise_note_pad/core/utils/toast_utils.dart';
import 'package:concise_note_pad/features/filters/enums/match_mode_mixin.dart';
import 'package:concise_note_pad/features/filters/models/task_field_filter.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registration.dart';
import 'package:concise_note_pad/features/filters/registry/task_filter_registry.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// 任务字段过滤器表单菜单
class TaskFieldFilterFormMenu extends StatefulWidget {
  final TaskFieldFilter? taskFieldFilter; // 任务字段过滤器 为空时为创建模式
  final TaskFilterRegistration registration; // 任务过滤器注册项
  final bool isReverse; // 反转
  final String field; // 字段
  final MatchModeMixin? matchModeMixin; // 模式
  final String pattern; // 样板

  // 创建字段过滤器
  TaskFieldFilter createFieldFilter(
    String field,
    MatchModeMixin mode,
    String pattern,
  ) {
    if (registration.buildField == null) {
      throw Exception('任务过滤器注册项未注册buildField');
    }
    return registration.buildField!(field, mode, pattern);
  }

  const TaskFieldFilterFormMenu.add({
    super.key,
    required this.registration,
    this.matchModeMixin,
    this.field = '',
    this.pattern = '',
  }) : taskFieldFilter = null,
       isReverse = false;
  TaskFieldFilterFormMenu.edit({super.key, required TaskFieldFilter filter})
    : taskFieldFilter = filter,
      isReverse = filter.isReverse,
      registration = TaskFilterRegistry.instance.getRegistration(filter.type)!,
      field = filter.field,
      matchModeMixin = filter.mode,
      pattern = filter.pattern.toString();

  @override
  State<StatefulWidget> createState() => _TaskFieldFilterFormMenuState();
}

class _TaskFieldFilterFormMenuState<T extends MatchModeMixin, enums>
    extends State<TaskFieldFilterFormMenu> {
  late bool isReverse; // 反转
  final TextEditingController _fieldController = TextEditingController();
  late MatchModeMixin? matchModeMixin; // 模式
  final TextEditingController _patternController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 同步复制到表单 //
    isReverse = widget.isReverse;
    _fieldController.text = widget.field;
    matchModeMixin = widget.matchModeMixin;
    _patternController.text = widget.pattern;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          TextField(
            controller: _fieldController,
            decoration: InputDecoration(
              icon: const Icon(Icons.abc),
              labelText: '字段',
            ),
          ),
          TextField(
            controller: _patternController,
            decoration: InputDecoration(
              icon: const Icon(Icons.short_text_rounded),
              labelText: '样板',
            ),
          ),
          CheckboxListTile(
            value: isReverse,
            title: Text('反转过滤器'),
            onChanged: (value) => setState(() => isReverse = value!),
          ), // 反转过滤器
          ListTile(
            title: Text('样板模式'),
            trailing: DropdownButton(
              items: widget.registration.modeValues!()
                  .map(
                    (mode) => DropdownMenuItem(
                      value: mode,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(mode.icon, color: importance.color),
                          Text(mode.displayName),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              value: matchModeMixin, // 当前选项
              onChanged: (MatchModeMixin? mode) {
                setState(() {
                  matchModeMixin = mode;
                }); // 更新
              },
            ),
          ), // 样板模式
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.cancel),
                label: const Text('取消'),
              ), // 创建按钮
              ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(
                  widget.taskFieldFilter == null ? Icons.add : Icons.save,
                ),
                label: Text(widget.taskFieldFilter == null ? '创建' : '保存'),
              ), // 创建按钮
            ],
          ),
        ],
      ),
    );
  }

  /// 提交
  void _submit() {
    // 样板模式不能为空
    if (matchModeMixin == null) {
      ToastUtils.showStandardToast(
        context,
        title: '表单验证错误',
        msg: '必须选择样板模式',
        type: ToastificationType.error,
      );
      return;
    }
    // 判断模式
    if (widget.taskFieldFilter == null) {
      // 创建 - 基本属性 //
      final fieldFilter = widget.createFieldFilter(
        _fieldController.text,
        matchModeMixin!,
        _patternController.text,
      );
      // 设置其他属性 //
      fieldFilter.isReverse = isReverse;
      Navigator.pop(context, fieldFilter); // 返回上一页，附带新的任务字段过滤器
    } else {
      // 保存
      widget.taskFieldFilter!
        ..isReverse = isReverse
        ..field = _fieldController.text
        ..mode = matchModeMixin!
        ..pattern = _patternController.text;
      Navigator.pop(context); // 返回上一页
    }
  }

  @override
  void dispose() {
    _fieldController.dispose();
    _patternController.dispose();
    super.dispose();
  }
}
