import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

/// 颜色数据转换器
class ColorDataConverter extends JsonConverter<Color, Map<String, dynamic>> {
  const ColorDataConverter();

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(json['color-ARGB32'] as int);
  }

  @override
  Map<String, dynamic> toJson(Color color) {
    return {'color-ARGB32': color.toARGB32()};
  }
}
