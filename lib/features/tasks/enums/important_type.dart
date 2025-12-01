import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// 重要性类型
///
/// 用于描述重要性区间的一部分
enum ImportanceType {
  notImportantNotUrgent, // 不重要不紧急
  urgentNotImportant, // 紧急不重要
  importantNotUrgent, // 重要不紧急
  importantAndUrgent; // 重要且紧急

  /// 默认值
  static ImportanceType get defaultValue => notImportantNotUrgent;

  /// 显示名称
  ///
  /// 将会显示译名
  String displayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return switch (this) {
      notImportantNotUrgent => loc.importanceTypeNotImportantNotUrgent,
      urgentNotImportant => loc.importanceTypeUrgentNotImportant,
      importantNotUrgent => loc.importanceTypeImportantNotUrgent,
      importantAndUrgent => loc.importanceTypeImportantAndUrgent,
    };
  }

  /// 图标
  IconData get icon => switch (this) {
    notImportantNotUrgent => Icons.do_disturb,
    urgentNotImportant => Icons.schedule,
    importantNotUrgent => Icons.warning_amber,
    importantAndUrgent => Icons.priority_high,
  };

  /// 颜色
  ///
  /// 推荐用于字体和图标
  Color get color => switch (this) {
    notImportantNotUrgent => Colors.grey,
    urgentNotImportant => Colors.green,
    importantNotUrgent => Colors.orange,
    importantAndUrgent => Colors.red,
  };

  /// 权值
  int get weightValue => switch (this) {
    notImportantNotUrgent => 0,
    urgentNotImportant => 10,
    importantNotUrgent => 20,
    importantAndUrgent => 30,
  };

  /// 比较
  ///
  /// 通过权值比较
  int compareTo(ImportanceType type) {
    if (weightValue < type.weightValue) {
      return -1;
    } else if (weightValue > type.weightValue) {
      return 1;
    } else {
      return 0;
    }
  }
}
