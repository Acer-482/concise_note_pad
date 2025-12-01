import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:concise_note_pad/features/tasks/models/completable_task_item.dart';
import 'package:concise_note_pad/features/tasks/forms/task_item_form_data.dart';
import 'package:concise_note_pad/features/tasks/task_manager.dart';
import 'package:concise_note_pad/core/utils/toast_utils.dart';
import 'package:concise_note_pad/features/tasks/widgets/pages/task_edit_page.dart';
import 'package:concise_note_pad/features/tasks/widgets/pages/task_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

/// 任务项
///
/// 任务项的抽象顶级基类
///
/// 包含基本的任务信息：标题、小标题、详情、启用、创建时间、变更时间
///
/// 如添加新子类的json序列化 请修改[TaskItem.fromJson]
abstract class TaskItem {
  /// 类型标识符
  String get type;

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
    if (json['type'] == null) throw ArgumentError('反序列化失败：type值为null');
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
  ///
  /// 子类允许序列化Json则必须重写
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {'type': type};
  }

  // 操作 //

  /// 显示详细信息
  Future<void> showInfo(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TaskItemInfoPage(taskItem: this)),
    );
  }

  /// 编辑任务
  void edit(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TaskEditPage.editTask(this)),
    );
    TaskManager.instance.update();
  }

  /// 删除任务
  void remove(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    TaskManager.instance.removeTaskItem(this); // 删除
    ToastUtils.showStandardToast(
      context,
      title: loc.delete,
      msg: loc.taskDeleteSuccess(title),
      type: ToastificationType.success,
    );
  }

  // UI //

  /// 构建为详细信息字典
  ///
  /// 字典的键值将会以 标题：内容的形式呈现出来
  @mustCallSuper
  Map<String, Widget> buildInfoMap(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return {
      loc.basicInformation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loc.titleLabel(title)),
          if (subTitle.isNotEmpty) Text(loc.subTitleLabel(subTitle)),
          Text(
            loc.createTimeLabel(
              DateFormat('yyyy/MM/dd - HH:mm:ss').format(createDateTime),
            ),
          ),
          if (updateDateTime != createDateTime)
            Text(
              loc.updateTimeLabel(
                DateFormat('yyyy/MM/dd - HH:mm:ss').format(updateDateTime),
              ),
            ),
        ],
      ),
      loc.detailedInformation: Text(details.isEmpty ? loc.noDetails : details),
    };
  }

  /// 构建为滑动列表
  @mustCallSuper
  List<SlidableAction> buildSlidableActions(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return [
      SlidableAction(
        onPressed: showInfo, // 显示信息页面
        label: loc.details,
        icon: Icons.info,
        backgroundColor: Colors.cyan,
      ),
      SlidableAction(
        onPressed: edit, // 弹出编辑对话框
        label: loc.edit,
        icon: Icons.edit,
        backgroundColor: Colors.yellowAccent,
      ),
      SlidableAction(
        onPressed: remove, // 删除
        label: loc.delete,
        icon: Icons.delete,
        backgroundColor: Colors.red,
      ),
    ];
  }

  /// 构建为表单数据
  TaskItemFormData toFormData();

  /// 构建为列表项卡片
  ///
  /// 参数：
  /// - [index] 当前所在索引
  Widget buildListTileCard(BuildContext context) {
    Color? leftHighlightColor = getLeftHighlightColor(); // 获取左侧高亮色条
    return Card(
      child: Slidable(
        key: ValueKey(title), // 设置标题作为唯一的key
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: buildSlidableActions(context),
        ), // 构建尾部滑动列表
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
            child: ListTile(
              leading: buildListTileLeading(context), // 头部
              trailing: buildListTileTrailing(context), // 尾部
              title: Text(title), // 标题
              subtitle: subTitle.isEmpty ? null : Text(subTitle), // 副标题
              enabled: isEnabled, // 启用
              onTap: () => showInfo(context), // 按下进入详细信息菜单
            ), // 内容项
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
