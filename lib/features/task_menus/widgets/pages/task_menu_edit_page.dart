import 'package:concise_note_pad/features/task_menus/models/task_menu.dart';
import 'package:concise_note_pad/features/task_menus/task_menu_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

/// 任务菜单编辑页面
class TaskMenuEditPage extends StatefulWidget {
  final TaskMenu? taskMenu; // 任务菜单

  const TaskMenuEditPage({super.key, this.taskMenu});

  @override
  State<StatefulWidget> createState() => _TaskMenuEditPageState();
}

class _TaskMenuEditPageState extends State<TaskMenuEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey(); // 表单验证键
  late final TextEditingController _titleController; // 标题控制器
  late IconData? iconData; // 图标数据
  late bool isPinned; // 固定标题栏

  @override
  void initState() {
    super.initState();
    final taskMenu = widget.taskMenu;
    _titleController = TextEditingController(text: taskMenu?.title ?? '新建标题栏');
    iconData = taskMenu?.iconData;
    isPinned = taskMenu?.isPinned ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskMenu == null ? '编辑任务菜单' : '新建${widget.taskMenu!.title}',
        ),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitForm,
        icon: const Icon(Icons.check),
        label: const Text('完成'),
      ),
    );
  }

  // 构建页面主题
  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: '标题',
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: _validatorTitle,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: iconData != null ? Icon(iconData) : Text('(无图标)'),
            title: Text('图标'),
            subtitle: Text('点击选择图标'),
            trailing: const Icon(Icons.arrow_right),
            onTap: _selectIconData,
          ),
          SwitchListTile(
            value: isPinned,
            onChanged: (v) => setState(() => isPinned = v),
            title: Text('固定标题栏'),
          ),
        ],
      ),
    );
  }

  // 验证标题
  String? _validatorTitle(String? v) {
    if (v == null || v.isEmpty) return '标题不能为空';
    return null;
  }

  // 提交验证表单
  bool _submitForm() {
    if (!_formKey.currentState!.validate()) return false; // 验证失败
    TaskMenu taskMenu;
    // 判断是否为新建模式
    if (widget.taskMenu == null) {
      taskMenu = TaskMenu(
        title: _titleController.text,
        iconData: iconData,
        isPinned: isPinned,
      );
      TaskMenuManager.instance.taskMenuList.add(taskMenu);
    } else {
      // 编辑模式 设置属性
      taskMenu = widget.taskMenu!;
      taskMenu.title = _titleController.text;
      taskMenu.iconData = iconData;
      taskMenu.isPinned = isPinned;
    }
    taskMenu.state.update(); // 更新状态
    TaskMenuManager.instance.update(); // 更新
    TaskMenuManager.instance.save(); // 保存状态
    Navigator.pop(context, taskMenu); // 返回
    return true; // 成功
  }

  // 选择图标
  Future<void> _selectIconData() async {
    final iconPickerIcon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        showTooltips: true,
        title: const Text('选择一个图标'),
        closeChild: Text('空图标'),
      ),
    );
    // 更新图标
    setState(() {
      iconData = iconPickerIcon?.data;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
