import 'package:concise_note_pad/task_item/check_task_item.dart';
import 'package:concise_note_pad/task_pages/task_edit_page.dart';
import 'package:concise_note_pad/task_pages/task_info_page.dart';
import 'package:concise_note_pad/task_item/task_item_form_data.dart';
import 'package:concise_note_pad/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

/// 任务项
///
/// 当重写子类后：
/// - 修改fromJson
///
/// 添加属性注意事项：
/// 1.在表单的initFromItem和updateItem中添加属性
/// 2.添加属性到任务项
/// 3.设置默认构造到任务项
/// 4.在表单的toItem中添加属性
/// 5.序列化反序列化Json
abstract class TaskItem {
  /// 标题
  String title;

  /// 小标题
  String subTitle;

  /// 详情
  String details;

  /// 启用
  bool isEnabled;

  /// 创建时间
  final DateTime createDateTime;

  /// 变更时间
  late DateTime updateDateTime;

  TaskItem({
    required this.title,
    this.subTitle = '',
    this.details = '',
    this.isEnabled = true,
    DateTime? createDateTime,
    DateTime? updateDateTime,
  }) : createDateTime = createDateTime ?? DateTime.now() {
    this.updateDateTime = updateDateTime ?? this.createDateTime.copyWith();
  }

  /// 从Json构造
  factory TaskItem.fromJson(Map<String, dynamic> json) {
    if (json['type'] == null) throw Exception('反序列化失败：type值为null');
    final type = json['type'] as String; // 获取类型
    // 根据类型构造子类
    switch (type) {
      case 'CompletableTaskItem':
        return CompletableTaskItem.fromJson(json);
      default:
        throw ArgumentError('反序列化失败：未知的类型$type');
    }
  }

  /// 序列化为Json
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {'type': type};
  }

  /// 类型标识符
  String get type;

  /// 构建为详细信息字典
  ///
  /// 字典的键值将会以 标题：内容的形式呈现出来
  @mustCallSuper
  Map<String, Widget> buildInfoMap() {
    return {
      '基本信息': Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('标题：$title'),
          if (subTitle.isNotEmpty) Text('副标题：$subTitle'),
          Text(
            "创建时间：${DateFormat('yyyy年MM月dd日 - HH时mm分ss秒').format(createDateTime)}",
          ),
          if (updateDateTime != createDateTime)
            Text(
              "最后更改：${DateFormat('yyyy年MM月dd日 - HH时mm分ss秒').format(updateDateTime)}",
            ),
        ],
      ),
      '详细信息': Text(details.isEmpty ? '（暂无详细信息）' : details),
    };
  }

  /// 构建为滑动列表
  @mustCallSuper
  List<SlidableAction> buildSlidableActions(BuildContext context) {
    return [
      SlidableAction(
        onPressed: (context) => _showInfoPage(context), // 显示信息页面
        label: '详细信息',
        icon: Icons.info,
        backgroundColor: Colors.cyan,
      ),
      SlidableAction(
        onPressed: (context) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskEditPage.editTask(this),
            ),
          );
          TaskManager.instance.update();
        }, // 弹出编辑对话框
        label: '编辑',
        icon: Icons.edit,
        backgroundColor: Colors.yellowAccent,
      ),
      SlidableAction(
        onPressed: (context) {
          TaskManager.instance.removeTaskItem(this); // 删除
        }, // 删除
        label: '删除',
        icon: Icons.delete,
        backgroundColor: Colors.red,
      ),
    ];
  }

  /// 构建为表单数据
  TaskItemFormData toFormData();

  // 显示手势菜单
  void _showGestureMenu(BuildContext context) {
    final RenderBox renderBox =
        context.findRenderObject() as RenderBox; // 获取正在显示的Box
    final offset = renderBox.localToGlobal(Offset.zero); // 获取偏移
    // 显示菜单 //
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + renderBox.size.width,
        offset.dy + renderBox.size.height,
      ), // 设置位置
      items: [
        PopupMenuItem(
          child: Row(
            children: [Icon(Icons.info), SizedBox(width: 8), Text('详细信息')],
          ),
        ),
      ],
    );
  }

  /// 显示详细信息页面
  Future<T?> _showInfoPage<T>(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TaskItemInfoPage(taskItem: this)),
    );
  }

  /// 构建为列表项卡片
  ///
  /// 参数：
  /// - [index] 当前所在索引
  Widget buildListTileCard(BuildContext context, int index) {
    Color? leftHighlightColor = getLeftHighlightColor(); // 获取左侧高亮色条
    return Card(
      child: Slidable(
        key: ValueKey(index), // 设置索引作为唯一的key
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: buildSlidableActions(context),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(6, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              border: leftHighlightColor != null
                  ? Border(
                      left: BorderSide(color: leftHighlightColor, width: 4),
                    )
                  : null, // 左侧高亮颜色
            ), // 装饰器
            child: GestureDetector(
              onLongPress: () => _showGestureMenu, // 长按
              onSecondaryTap: () => _showGestureMenu, // 右键
              child: ListTile(
                leading: buildListTileLeading(context), // 头部
                trailing: buildListTileTrailing(context), // 尾部
                title: Text(title), // 标题
                subtitle: subTitle.isEmpty ? null : Text(subTitle), // 副标题
                enabled: isEnabled, // 启用
                onTap: () => _showInfoPage(context), // 按下进入详细信息菜单
              ), // 内容项
            ), // 手势检测器
          ), // 容器 用于显示左侧高亮色条
        ), // 内边距
      ), // 滑动组件 支持右滑出菜单
    ); // 内容菜单
  }

  /// 构建为列表项头部
  Widget? buildListTileLeading(BuildContext context) {
    return details.isEmpty
        ? Icon(Icons.view_list_rounded)
        : Icon(Icons.info_outline);
  }

  /// 构建为列表项尾部
  Widget? buildListTileTrailing(BuildContext context) {
    return null;
  }

  /// 获取高亮色条
  Color? getLeftHighlightColor() => null;
}
