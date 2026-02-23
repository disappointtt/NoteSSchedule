import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const String _notificationsKey = 'notifications_enabled';
  static const String _themeModeKey = 'theme_mode';
  static const String _fontScaleKey = 'font_scale';

  late SharedPreferences _prefs;
  bool _notificationsEnabled = true;
  ThemeMode _themeMode = ThemeMode.light;
  double _fontScale = 1.0;

  bool get notificationsEnabled => _notificationsEnabled;
  ThemeMode get themeMode => _themeMode;
  double get fontScale => _fontScale;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
  }

  void _loadSettings() {
    _notificationsEnabled = _prefs.getBool(_notificationsKey) ?? true;
    final themeModeIndex = _prefs.getInt(_themeModeKey) ?? 0;
    _themeMode = ThemeMode.values[themeModeIndex];
    _fontScale = _prefs.getDouble(_fontScaleKey) ?? 1.0;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    await _prefs.setBool(_notificationsKey, enabled);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setInt(_themeModeKey, mode.index);
    notifyListeners();
  }

  Future<void> setFontScale(double scale) async {
    _fontScale = scale;
    await _prefs.setDouble(_fontScaleKey, scale);
    notifyListeners();
  }
}
