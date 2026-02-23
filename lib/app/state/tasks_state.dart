import 'package:flutter/material.dart';
import 'package:notes_schedule/models/task.dart';
import 'package:notes_schedule/models/category.dart';
import 'package:notes_schedule/models/reminder.dart';
import 'package:uuid/uuid.dart';

enum ContentType { tasks, meetings, reminders }


// Состояние задач, встреч и напоминаний (студенческий стиль)
class TasksState extends ChangeNotifier {
  // выбранная дата (по умолчанию сегодня)
  DateTime _selectedDate = DateTime.now();
  // тут храним задачи по дате
  Map<DateTime, List<Task>> _tasksByDate = {};
  // тут храним встречи по дате
  Map<DateTime, List<Task>> _meetingsByDate = {};
  // все напоминания (без привязки к дате)
  List<Reminder> _reminders = [];
  // история выполненных задач/встреч
  List<Task> _completedHistory = [];
  // какой тип контента сейчас выбран (по умолчанию задачи)
  ContentType _currentContentType = ContentType.tasks;


  // Геттеры для доступа к данным
  DateTime get selectedDate => _selectedDate;
  List<Task> get tasksForSelectedDate => _getTasksForDate(_selectedDate);
  List<Task> get meetingsForSelectedDate => _getMeetingsForDate(_selectedDate);
  List<Reminder> get remindersForSelectedDate => _getRemindersForDate(_selectedDate);
  List<Task> get completedHistory => _completedHistory;
  List<Reminder> get reminders => _reminders;
  ContentType get currentContentType => _currentContentType;

  // Просто считаем общее количество (можно было и по-другому)
  int get tasksCount => _tasksByDate.values.expand((x) => x).length;
  int get meetingsCount => _meetingsByDate.values.expand((x) => x).length;
  int get remindersCount => _reminders.length;

  // конструктор
  TasksState() {
    // инициализация тестовых данных
    _initializeMockData();
  }

  void _initializeMockData() {
    final today = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    // Mock tasks for today
    _tasksByDate[today] = [
      Task(
        id: const Uuid().v4(),
        title: 'Совещание с командой',
        time: '09:00',
        category: TaskCategory.work,
        date: today,
      ),
      Task(
        id: const Uuid().v4(),
        title: 'Лекция по истории',
        time: '11:00',
        category: TaskCategory.study,
        date: today,
      ),
      Task(
        id: const Uuid().v4(),
        title: 'Тренировка',
        time: '13:00',
        category: TaskCategory.health,
        date: today,
      ),
    ];

    // Mock meetings for today
    _meetingsByDate[today] = [
      Task(
        id: const Uuid().v4(),
        title: 'Планерка отдела',
        time: '10:00',
        category: TaskCategory.work,
        date: today,
      ),
      Task(
        id: const Uuid().v4(),
        title: 'Встреча с клиентом',
        time: '14:00',
        category: TaskCategory.work,
        date: today,
      ),
    ];

    // Mock reminders
    _reminders.add(
      Reminder(
        id: const Uuid().v4(),
        title: 'Позвонить маме',
        dateTime: today.add(const Duration(hours: 15)),
      ),
    );
    _reminders.add(
      Reminder(
        id: const Uuid().v4(),
        title: 'Купить молоко',
        dateTime: today.add(const Duration(hours: 17)),
      ),
    );
    _reminders.add(
      Reminder(
        id: const Uuid().v4(),
        title: 'Встреча с другом',
        dateTime: today.add(const Duration(hours: 19)),
      ),
    );
  }

  List<Task> _getTasksForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return _tasksByDate[normalizedDate] ?? [];
  }

  List<Task> _getMeetingsForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return _meetingsByDate[normalizedDate] ?? [];
  }

  List<Reminder> _getRemindersForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return _reminders
        .where((r) =>
            r.dateTime.year == normalizedDate.year &&
            r.dateTime.month == normalizedDate.month &&
            r.dateTime.day == normalizedDate.day)
        .toList();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setContentType(ContentType type) {
    _currentContentType = type;
    notifyListeners();
  }

  void addTask(String title, String time, TaskCategory category) {
    final normalizedDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    final task = Task(
      id: const Uuid().v4(),
      title: title,
      time: time,
      category: category,
      date: normalizedDate,
    );

    if (!_tasksByDate.containsKey(normalizedDate)) {
      _tasksByDate[normalizedDate] = [];
    }

    _tasksByDate[normalizedDate]!.add(task);
    _tasksByDate[normalizedDate]!.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  void addMeeting(String title, String time, TaskCategory category) {
    final normalizedDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    final meeting = Task(
      id: const Uuid().v4(),
      title: title,
      time: time,
      category: category,
      date: normalizedDate,
    );

    if (!_meetingsByDate.containsKey(normalizedDate)) {
      _meetingsByDate[normalizedDate] = [];
    }

    _meetingsByDate[normalizedDate]!.add(meeting);
    _meetingsByDate[normalizedDate]!.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  void completeTask(String taskId) {
    for (var tasks in _tasksByDate.values) {
      final index = tasks.indexWhere((t) => t.id == taskId);
      if (index != -1) {
        final completedTask = tasks[index].copyWith(isCompleted: true);
        _completedHistory.add(completedTask);
        tasks.removeAt(index);
        notifyListeners();
        return;
      }
    }
  }

  void completeMeeting(String meetingId) {
    for (var meetings in _meetingsByDate.values) {
      final index = meetings.indexWhere((m) => m.id == meetingId);
      if (index != -1) {
        final completedMeeting = meetings[index].copyWith(isCompleted: true);
        _completedHistory.add(completedMeeting);
        meetings.removeAt(index);
        notifyListeners();
        return;
      }
    }
  }

  void completeReminder(String reminderId) {
    final index = _reminders.indexWhere((r) => r.id == reminderId);
    if (index != -1) {
      _reminders.removeAt(index);
      notifyListeners();
    }
  }

  void addReminder(String title, DateTime dateTime) {
    _reminders.add(
      Reminder(
        id: const Uuid().v4(),
        title: title,
        dateTime: dateTime,
      ),
    );
    notifyListeners();
  }

  void deleteTask(String taskId) {
    for (var tasks in _tasksByDate.values) {
      tasks.removeWhere((t) => t.id == taskId);
    }
    notifyListeners();
  }

  void deleteMeeting(String meetingId) {
    for (var meetings in _meetingsByDate.values) {
      meetings.removeWhere((m) => m.id == meetingId);
    }
    notifyListeners();
  }
}
