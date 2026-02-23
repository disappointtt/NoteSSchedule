import 'package:flutter/material.dart';

/// Экран настроек приложения

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Язык приложения'),
            subtitle: const Text('Русский'),
            onTap: () {
              // TODO: Реализовать выбор языка
            },
          ),
          ListTile(
            title: const Text('Тема оформления'),
            subtitle: const Text('Светлая'),
            onTap: () {
              // TODO: Реализовать выбор темы
            },
          ),
          ListTile(
            title: const Text('Уведомления'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TODO: Изменить параметр уведомлений
              },
            ),
          ),
          ListTile(
            title: const Text('О приложении'),
            onTap: () {
              // TODO: Показать информацию о приложении
            },
          ),
        ],
      ),
    );
  }
}
