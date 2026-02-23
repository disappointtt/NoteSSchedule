import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_schedule/app/widgets/date_strip.dart';
import 'package:notes_schedule/app/state/tasks_state.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';
import 'package:notes_schedule/models/task.dart';
import 'package:notes_schedule/models/reminder.dart';
import 'package:notes_schedule/models/category.dart';


class CalendarStub extends StatefulWidget {
  const CalendarStub({Key? key}) : super(key: key);

  @override
  State<CalendarStub> createState() => _CalendarStubState();
}

class _CalendarStubState extends State<CalendarStub> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final tasksState = Provider.of<TasksState>(context);
    final tasks = tasksState.tasksForSelectedDate;
    final meetings = tasksState.meetingsForSelectedDate;
    final reminders = tasksState.remindersForSelectedDate;

    return Column(
      children: [
        const SizedBox(height: 32),
        DateStrip(
          selectedDate: _selectedDate,
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
              tasksState.selectDate(date);
            });
          },
        ),
        const SizedBox(height: 24),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Задачи', style: Theme.of(context).textTheme.titleMedium),
                ...tasks.isEmpty
                    ? [Text('Нет задач на этот день', style: TextStyle(color: AppTheme.textSecondary))]
                    : tasks.map((task) => _TaskTile(task: task)).toList(),
                const SizedBox(height: 20),
                Text('Встречи', style: Theme.of(context).textTheme.titleMedium),
                ...meetings.isEmpty
                    ? [Text('Нет встреч на этот день', style: TextStyle(color: AppTheme.textSecondary))]
                    : meetings.map((meeting) => _TaskTile(task: meeting, isMeeting: true)).toList(),
                const SizedBox(height: 20),
                Text('Напоминания', style: Theme.of(context).textTheme.titleMedium),
                ...reminders.isEmpty
                    ? [Text('Нет напоминаний на этот день', style: TextStyle(color: AppTheme.textSecondary))]
                    : reminders.map((reminder) => _ReminderTile(reminder: reminder)).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  final bool isMeeting;
  const _TaskTile({Key? key, required this.task, this.isMeeting = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Text(task.category.emoji, style: const TextStyle(fontSize: 20)),
        title: Text(task.title),
        subtitle: Text('${task.time}  |  ${task.category.label}'),
        trailing: isMeeting ? const Icon(Icons.event) : null,
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  final Reminder reminder;
  const _ReminderTile({Key? key, required this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Text('🔔', style: TextStyle(fontSize: 20)),
        title: Text(reminder.title),
        subtitle: Text('${reminder.dateTime.hour.toString().padLeft(2, '0')}:${reminder.dateTime.minute.toString().padLeft(2, '0')}'),
      ),
    );
  }
}
