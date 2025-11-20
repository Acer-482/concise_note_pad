import 'package:concise_note_pad/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// 页面实用方法类
@immutable
class PageUtils {
  /// 构建默认应用栏
  static AppBar buildDefaultAppbar(
    BuildContext context,
    Widget title, {
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary, // 背景颜色
      title: title,
      actions: actions,
    );
  }

  /// 构建默认标题框架
  static Widget buildDefaultTitleFrame({
    required BuildContext context,
    required String title,
    Widget? childWidget,
  }) {
    return Card(
      color: Theme.of(context).cardColor, // 颜色
      shadowColor: Theme.of(context).colorScheme.inverseSurface, // 阴影颜色
      child: Container(
        padding: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ), // 标题
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: childWidget, // 子组件
            ),
          ],
        ),
      ),
    );
  }

  /// 显示默认模态底部表
  static Future<T?> showDefaultModalBottomSheet<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet(
      showDragHandle: true, // 显示拖动句柄
      context: context,
      builder: (context) => ListView(
        children: <Widget>[
          if (title != null)
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ), // 标题
          Container(padding: padding, child: child),
        ], // 内容,
      ),
    ); // 显示模态底部表
  }

  /// 显示删除确认对话框
  static Future<bool> showDeleteConfirmDialog(
    BuildContext context, {
    String? completedMessage,
    bool showToast = true,
    void Function()? confirmFunc,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认删除？'),
        content: Text('这将会删除整个复合过滤器以及其存储的所有过滤器！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // 返回上一页
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              confirmFunc?.call(); // 执行
              if (showToast) {
                ToastUtils.showStandardToast(
                  context,
                  title: completedMessage == null ? null : '删除成功', // 有完成消息
                  msg: completedMessage ?? '删除成功',
                  type: ToastificationType.success,
                );
              }
              Navigator.pop(context, true); // 返回上一页
            },
            child: const Text('确定', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
