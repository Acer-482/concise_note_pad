import 'package:flutter/material.dart';

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
    required List<Widget> children,
  }) {
    return showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => Card(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children:
                <Widget>[
                  if (title != null)
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ), // 标题
                ] +
                children, // 内容
          ),
        ),
      ),
    ); // 显示模态底部表
  }
}
