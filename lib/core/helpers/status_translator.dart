import 'package:flutter/material.dart';

class StatusTranslator {
  static const Map<String, String> _statusTranslations = {
    'NOT_RECORDED': 'Черновик',
    'RECORDED': 'Проведен',
    // Другие статусы
  };

  static const Map<String, Color> _statusColors = {
    'NOT_RECORDED': Color.fromRGBO(76, 178, 189, 1), 
    'RECORDED': Colors.green, 
  };

  static String translate(String status) {
    return _statusTranslations[status] ?? status;
  }

  static Color getStatusColor(String status) {
    return _statusColors[status] ??
        Colors.black; // Цвет по умолчанию, если статус неизвестен
  }
}
