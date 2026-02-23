/// Константы приложения

class AppConstants {
  // Категории
  static const List<String> defaultCategories = [
    'Работа',
    'Учеба',
    'Личное',
    'Здоровье',
    'Покупки',
    'Встреча',
  ];

  // Времена уведомлений (в минутах до события)
  static const List<int> reminderOptions = [5, 10, 15, 30, 60];

  // Стандартное время напоминания
  static const int defaultReminderMinutes = 15;

  // API endpoints (если будет синхронизация)
  static const String apiBaseUrl = 'https://api.noteschedule.com';
}

class AppStrings {
  static const String appName = 'NoteSSchedule';
  static const String appTagline = 'Умный планировщик с напоминаниями';
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
}
