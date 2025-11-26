import 'package:concise_note_pad/features/task_filters/models/composite_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/field_filters/boolean_task_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/field_filters/date_time_task_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/field_filters/duration_task_filter.dart';
import 'package:concise_note_pad/features/task_filters/models/field_filters/text_task_filter.dart';
import 'package:concise_note_pad/features/task_filters/registry/task_filter_registration.dart';

/// 任务过滤器注册器
class TaskFilterRegistry {
  // 单例设计
  static final TaskFilterRegistry _instance = TaskFilterRegistry._internal();
  static TaskFilterRegistry get instance => _instance;
  TaskFilterRegistry._internal();

  /// 注册列表
  final Map<String, TaskFilterRegistration> _registryList = {};

  /// 初始化注册
  ///
  /// 当添加新的TaskFilter子类时 请修改
  void initAllRegister() {
    CompositeFilter.initRegistry();
    TextTaskFilter.initRegistry();
    BooleanTaskFilter.initRegistry();
    DateTimeTaskFilter.initRegistry();
    DurationTaskFilter.initRegistry();
  }

  /// 注册
  void register(TaskFilterRegistration registration) {
    _registryList[registration.type] = registration;
  }

  /// 获取注册信息
  TaskFilterRegistration? getRegistration(String type) {
    return _registryList[type];
  }

  /// 获取所有注册信息
  List<TaskFilterRegistration> getAllRegistration() {
    return _registryList.values.map((e) => e).toList();
  }
}
