/// 日志等级
enum LogLevel {
  info,
  warning,

  error;

  String get name => switch (this) {
    info => 'INFO',
    warning => 'WARNING',
    error => 'ERROR',
  };
}
