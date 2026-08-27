import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ColorConverter implements JsonConverter<Color, dynamic> {
  const ColorConverter();

  @override
  Color fromJson(dynamic json) {
    if (json is int) return Color(json);
    if (json is num) return Color(json.toInt());
    if (json is String) {
      final parsed = int.tryParse(json);
      if (parsed != null) return Color(parsed);
    }
    return const Color(0xFF4CAF50);
  }

  @override
  dynamic toJson(Color object) => object.toARGB32();
}
