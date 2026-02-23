import 'package:notes_schedule/models/category.dart';

class Task {
  final String id;
  final String title;
  final String time; // HH:mm format
  final TaskCategory category;
  final DateTime date;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    required this.date,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? time,
    TaskCategory? category,
    DateTime? date,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      category: category ?? this.category,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() => 'Task(id: $id, title: $title, time: $time, category: ${category.label}, isCompleted: $isCompleted)';
}
