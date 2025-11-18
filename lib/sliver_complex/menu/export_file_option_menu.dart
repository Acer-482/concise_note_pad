import 'package:flutter/material.dart';

/// 导出文件设置菜单
class ExportFileOptionMenu extends StatefulWidget {
  const ExportFileOptionMenu({super.key});

  @override
  State<StatefulWidget> createState() => _ExportFileOptionMenuState();
}

class _ExportFileOptionMenuState extends State<ExportFileOptionMenu> {
  bool exportAppbarConfig = true; // 导出菜单配置文件
  bool exportAllTaskConfig = true; // 导出所有任务

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('导出菜单配置文件'),
            trailing: Checkbox(
              value: exportAppbarConfig,
              onChanged: (v) => setState(() => exportAppbarConfig = v!),
            ),
          ),
          ListTile(
            title: Text('导出所有任务'),
            trailing: Checkbox(
              value: exportAllTaskConfig,
              onChanged: (v) => setState(() => exportAllTaskConfig = v!),
            ),
          ),
        ],
      ),
    );
  }
}
