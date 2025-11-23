/// 字符串转换工具类
class StringCastUtils {
  /// 字符串转布尔
  static bool strToBoolean(dynamic v) {
    final str = v.toString().toLowerCase().trim();
    return str == 'true' || str == '1' || str == 'yes' || str == 'y';
  }

  /// 字符串转时间
  static DateTime? strToDateTime(dynamic v) {
    if (v == null) return null;

    final clean = v.toString().trim();

    // 尝试标准格式
    DateTime? result = DateTime.tryParse(clean);
    if (result != null) return result;

    // 尝试替换空格为T
    result = DateTime.tryParse(clean.replaceAll(' ', 'T'));
    if (result != null) return result;

    // 尝试仅年份
    if (RegExp(r'^\d{4}$').hasMatch(clean)) {
      return DateTime(int.parse(clean));
    }

    // 尝试时间戳（秒或毫秒）
    final timestamp = int.tryParse(clean);
    if (timestamp != null) {
      if (timestamp > 1000000000000) {
        // 毫秒时间戳
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else if (timestamp > 1000000000) {
        // 秒时间戳
        return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      }
    }

    return null;
  }

  /// 字符串转持续时间
  static Duration? strToDuration(dynamic v) {
    if (v == null) return null;

    final input = v.toString().trim();
    if (input.isEmpty) return null;

    // 尝试解析标准格式 - "HH:mm:ss.mmmmmm" //
    final match = RegExp(r'^(\d+):(\d+):(\d+)(?:\.(\d+))?$').firstMatch(input);
    if (match != null) {
      final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
      final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
      final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;
      final micros =
          int.tryParse((match.group(4) ?? '0').padRight(6, '0')) ?? 0;

      return Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        microseconds: micros,
      );
    }
    // 尝试解析易读格式，如"1h 30m 15s" //
    final humanMatch = RegExp(
      r'(\d+)\s*(d|h|m|s)',
    ).allMatches(input.toLowerCase());
    if (humanMatch.isNotEmpty) {
      int days = 0, hours = 0, minutes = 0, seconds = 0;

      for (final match in humanMatch) {
        final value = int.tryParse(match.group(1) ?? '0') ?? 0;
        switch (match.group(2)) {
          case 'd':
            days = value;
            break;
          case 'h':
            hours = value;
            break;
          case 'm':
            minutes = value;
            break;
          case 's':
            seconds = value;
            break;
        }
      }

      return Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      );
    }
    // 尝试解析纯数字（秒） //
    final seconds = int.tryParse(input);
    if (seconds != null && seconds >= 0) {
      return Duration(seconds: seconds);
    }
    return null;
  }
}
