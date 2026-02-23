/// Сервис для работы с локальным хранилищем (SharedPreferences)
/// Сохраняет настройки приложения и пользовательские предпочтения

class StorageService {
  // TODO: Сохранение пользовательских настроек
  // TODO: Загрузка сохраненных данных
  // TODO: Работа с кешем

  Future<void> saveAppSettings({
    required String key,
    required dynamic value,
  }) async {
    // Сохранить параметр в хранилище
  }

  Future<dynamic> getAppSettings(String key) async {
    // Получить параметр из хранилища
    return null;
  }
}
