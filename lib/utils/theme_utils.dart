import 'package:flutter/material.dart';

/// Утилиты для работы с темой оформления приложения

class ThemeUtils {
  // Основные цвета
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color accentColor = Color(0xFFFF6B6B);
  
  // Нейтральные цвета
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  
  // Цвета категорий
  static const Map<String, Color> categoryColors = {
    'Работа': Color(0xFF2196F3),      // Синий
    'Учеба': Color(0xFF4CAF50),       // Зелёный
    'Личное': Color(0xFFFFC107),      // Оранжевый
    'Здоровье': Color(0xFFE91E63),    // Розовый
    'Покупки': Color(0xFF9C27B0),     // Фиолетовый
    'Встреча': Color(0xFF00BCD4),     // Голубой
  };

  /// Получить цвет категории
  static Color getCategoryColor(String category) {
    return categoryColors[category] ?? primaryColor;
  }
}
