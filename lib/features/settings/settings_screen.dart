import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_schedule/app/state/app_settings.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';
import 'package:notes_schedule/app/widgets/soft_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = context.watch<AppSettings>();
    final bgColor = isDark ? Colors.grey[900]! : AppTheme.bgCard;
    final dividerColor = isDark ? Colors.grey[800]! : AppTheme.borderLight;
    final chevronColor = isDark ? Colors.grey[600]! : AppTheme.textSecondary;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Row(
              children: [
                Text(
                  'Настройки',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),

          // Main Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'Основное',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SoftCard(
                backgroundColor: bgColor,
                child: Column(
                  children: [
                    // Notifications
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Уведомления',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Switch(
                            value: settings.notificationsEnabled,
                            onChanged: (value) {
                              settings.setNotificationsEnabled(value);
                            },
                            activeColor: AppTheme.primaryPurple,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    // Date & Time
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Дата и время',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: chevronColor,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    // Categories
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Категории задач',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: chevronColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Design Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'Оформление',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SoftCard(
                backgroundColor: bgColor,
                child: Column(
                  children: [
                    // Theme
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Тема приложения',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              _ThemeButton(
                                label: 'Светлая',
                                isSelected: settings.themeMode == ThemeMode.light,
                                onTap: () {
                                  settings.setThemeMode(ThemeMode.light);
                                },
                              ),
                              const SizedBox(width: 8),
                              _ThemeButton(
                                label: 'Тёмная',
                                isSelected: settings.themeMode == ThemeMode.dark,
                                onTap: () {
                                  settings.setThemeMode(ThemeMode.dark);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    // Font Size
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Размер шрифта',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              _FontSizeButton(
                                label: 'A',
                                size: 'S',
                                isSelected: settings.fontScale == 0.9,
                                onTap: () {
                                  settings.setFontScale(0.9);
                                },
                              ),
                              const SizedBox(width: 6),
                              _FontSizeButton(
                                label: 'A',
                                size: 'M',
                                isSelected: settings.fontScale == 1.0,
                                onTap: () {
                                  settings.setFontScale(1.0);
                                },
                              ),
                              const SizedBox(width: 6),
                              _FontSizeButton(
                                label: 'A',
                                size: 'L',
                                isSelected: settings.fontScale == 1.15,
                                onTap: () {
                                  settings.setFontScale(1.15);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Data Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'Данные',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SoftCard(
                backgroundColor: bgColor,
                child: Column(
                  children: [
                    // Local Storage
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Локальное хранилище',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '37.2 МБ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => _showClearDataDialog(context),
                            child: Icon(
                              Icons.chevron_right,
                              color: chevronColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    // Backup
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Резервное копирование',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: chevronColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // About Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'О приложении',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SoftCard(
                backgroundColor: bgColor,
                child: Column(
                  children: [
                    // Support
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Поддержка',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          GestureDetector(
                            onTap: () => _showSupportDialog(context),
                            child: Icon(
                              Icons.chevron_right,
                              color: chevronColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    // About App
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'О NoteSSchedule',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          GestureDetector(
                            onTap: () => _showAboutDialog(context),
                            child: Icon(
                              Icons.chevron_right,
                              color: chevronColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Очистить данные?'),
        content: const Text('Это действие нельзя отменить. Все данные будут удалены.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Данные очищены')),
              );
            },
            child: const Text('Очистить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Поддержка'),
        content: const Text(
          'Свяжитесь с нами:\n\n'
          '📧 Email: support@notesschedule.com\n'
          '💬 Telegram: @NoteSSchedule\n\n'
          'Мы рады помочь вам!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('О NoteSSchedule'),
        content: const Text(
          'NoteSSchedule v1.0.0\n\n'
          'Умный планировщик с напоминаниями.\n\n'
          'Помогает организовать ваш день и не забыть о важных делах.\n\n'
          '© 2025 NoteSSchedule',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryPurple : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.primaryPurple : AppTheme.borderLight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _FontSizeButton extends StatelessWidget {
  final String label;
  final String size;
  final bool isSelected;
  final VoidCallback onTap;

  const _FontSizeButton({
    required this.label,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sizeMap = {
      'S': 16.0,
      'M': 18.0,
      'L': 20.0,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryPurple : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.primaryPurple : AppTheme.borderLight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: sizeMap[size],
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
