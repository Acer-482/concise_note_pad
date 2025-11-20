import 'package:flutter/material.dart';

/// 任务项文本字段
///
/// 代表任务项的可用文本字段
enum TaskItemTextField {
  title,
  subTitle,
  details;

  /// 显示名称
  String get displayName => switch (this) {
    title => '标题',
    subTitle => '副标题',
    details => '内容',
  };

  /// 图标
  Icon get icon => switch (this) {
    title => const Icon(Icons.title_rounded),
    subTitle => const Icon(Icons.text_fields_rounded),
    details => const Icon(Icons.text_format_rounded),
  };
}
