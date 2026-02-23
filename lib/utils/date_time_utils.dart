import 'package:intl/intl.dart';

/// Утилиты для работы с датами и временем

class DateTimeUtils {
  /// Форматирование даты в строку
  static String formatDate(DateTime dateTime, {String format = 'dd.MM.yyyy'}) {
    return DateFormat(format).format(dateTime);
  }

  /// Форматирование времени в строку
  static String formatTime(DateTime dateTime, {String format = 'HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }

  /// Форматирование даты и времени в строку
  static String formatDateTime(DateTime dateTime, {String format = 'dd.MM.yyyy HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }

  /// Проверка, является ли дата сегодня
  static bool isToday(DateTime dateTime) {
    final today = DateTime.now();
    return dateTime.year == today.year &&
        dateTime.month == today.month &&
        dateTime.day == today.day;
  }

  /// Получить отображаемую строку даты (Сегодня, Завтра, или конкретная дата)
  static String getDisplayDate(DateTime dateTime) {
    if (isToday(dateTime)) {
      return 'Сегодня';
    }
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    if (dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day) {
      return 'Завтра';
    }
    return formatDate(dateTime);
  }
}
