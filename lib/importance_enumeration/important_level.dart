import 'package:flutter/material.dart';

/// 重要重要程度等级
/// 
/// 用于描述一个任务的重要程度
enum ImportanceLevel {
  minimum, // 最低
  low, // 低
  medium, // 中
  high, // 高
  critical; // 最高

  /// 默认值
  static ImportanceLevel get defaultValue => minimum;

  /// 显示名称
  /// 
  /// 将会显示译名
  String get displayName => switch (this) {
    minimum => '最低',
    low => '低',
    medium => '中',
    high => '高',
    critical => '最高',
  };

  /// 图标
  IconData get icon => switch (this) {
    minimum => Icons.do_disturb,
    low => Icons.arrow_downward,
    medium => Icons.remove,
    high => Icons.arrow_upward,
    critical => Icons.priority_high,
  };

  /// 颜色
  Color get color => switch (this) {
    minimum => Colors.grey.shade500,
    low => Colors.blue.shade500,
    medium => Colors.green.shade600,
    high => Colors.orange.shade600,
    critical => Colors.red.shade700,
  };

  /// 权值
  int get weightValue => switch (this) {
    minimum => 1,
    low => 3,
    medium => 5,
    high => 7,
    critical => 9,
  };

  /// 比较
  /// 
  /// 通过权值比较
  int compareTo(ImportanceLevel level) {
    if (weightValue < level.weightValue) {
      return -1;
    } else if (weightValue > level.weightValue) {
      return 1;
    } else {
      return 0;
    }
  }
}
