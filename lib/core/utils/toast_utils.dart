import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// 弹窗工具类
///
/// 提供程序弹窗的实用方法
class ToastUtils {
  /// 显示标准弹窗信息
  ///
  /// 参数：
  /// - [context] 上下文
  /// - [msg] 消息内容
  /// - [autoCloseDuration] 自动关闭时间
  /// - [type] 类型
  /// - [style] 样式
  static void showStandardToast(
    BuildContext context, {
    String? title,
    required String msg,
    Duration autoCloseDuration = const Duration(seconds: 3),
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
  }) {
    toastification.show(
      context: context,
      title: title == null ? null : Text(title), // 标题
      description: Text(msg), // 内容
      type: type, // 类型
      style: style, // 样式
      // alignment: AlignmentGeometry.bottomRight, // 位置
      autoCloseDuration: autoCloseDuration, // 关闭时间
      showProgressBar: true, // 显示进度条
    );
  }
}
