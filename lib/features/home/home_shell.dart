import 'package:flutter/material.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';
import 'package:notes_schedule/features/tasks/tasks_screen.dart';
import 'package:notes_schedule/features/calendar/calendar_stub.dart';
import 'package:notes_schedule/features/settings/settings_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({Key? key}) : super(key: key);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TasksScreen(),
    const CalendarStub(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? Colors.grey[800]! : AppTheme.borderLight,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppTheme.bgCard,
          selectedItemColor: AppTheme.primaryPurple,
          unselectedItemColor: isDark ? Colors.grey[600] : AppTheme.textSecondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              activeIcon: Icon(Icons.check_circle),
              label: 'Задачи',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Календарь',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Настройки',
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 96.0), // Поднимаем кнопки выше навигации
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () => _showAddTaskDialog(context),
                    backgroundColor: AppTheme.primaryPurple,
                    icon: const Icon(Icons.add_task),
                    label: const Text('Новая задача'),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton.extended(
                    onPressed: () => _showAddMeetingDialog(context),
                    backgroundColor: AppTheme.accentGreen,
                    icon: const Icon(Icons.event),
                    label: const Text('Добавить встречу'),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton.extended(
                    onPressed: () => _showAddReminderDialog(context),
                    backgroundColor: AppTheme.accentOrange,
                    icon: const Icon(Icons.notifications_active),
                    label: const Text('Напоминание'),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    DateTime? selectedDate = DateTime.now();
    String? selectedCategory;
    final categories = ['Работа', 'Учёба', 'Личное', 'Здоровье', 'Покупки'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Новая задача'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Название задачи',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: const Text('Категория'),
                  items: categories.map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  )).toList(),
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    hintText: 'Время (ЧЧ:мм)',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate != null
                          ? 'Дата: ${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}'
                          : 'Дата не выбрана'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => selectedDate = picked);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && timeController.text.isNotEmpty && selectedCategory != null && selectedDate != null) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Задача «${titleController.text}» добавлена'),
                      duration: const Duration(milliseconds: 1500),
                    ),
                  );
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMeetingDialog(BuildContext context) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    DateTime? selectedDate = DateTime.now();
    String? selectedCategory;
    final categories = ['Работа', 'Учёба', 'Личное', 'Здоровье', 'Покупки'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Добавить встречу'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Название встречи',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: const Text('Категория'),
                  items: categories.map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  )).toList(),
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    hintText: 'Время (ЧЧ:мм)',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate != null
                          ? 'Дата: ${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}'
                          : 'Дата не выбрана'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => selectedDate = picked);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && timeController.text.isNotEmpty && selectedCategory != null && selectedDate != null) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Встреча «${titleController.text}» добавлена'),
                      duration: const Duration(milliseconds: 1500),
                    ),
                  );
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReminderDialog(BuildContext context) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    DateTime? selectedDate = DateTime.now();
    String? selectedCategory;
    final categories = ['Работа', 'Учёба', 'Личное', 'Здоровье', 'Покупки'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Новое напоминание'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Название напоминания',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: const Text('Категория'),
                  items: categories.map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  )).toList(),
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    hintText: 'Время (ЧЧ:мм)',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate != null
                          ? 'Дата: ${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}'
                          : 'Дата не выбрана'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => selectedDate = picked);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && timeController.text.isNotEmpty && selectedCategory != null && selectedDate != null) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Напоминание «${titleController.text}» добавлено'),
                      duration: const Duration(milliseconds: 1500),
                    ),
                  );
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
