import 'package:flutter/material.dart';

/// 任务菜单设置页面
class TaskMenuSettingPage extends StatefulWidget {
  const TaskMenuSettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskMenuSettingPageState();
}

class _TaskMenuSettingPageState extends State<TaskMenuSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('任务菜单设置')),
      body: _buildBody(),
    );
  }

  // 构建页面主题
  Widget? _buildBody() {
    return null;
  }
}
