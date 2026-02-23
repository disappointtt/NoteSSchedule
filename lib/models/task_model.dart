/// Модель данных для задачи/события в приложении
class TaskModel {
  final String id;
  final String title;
  final String? description;
  final DateTime dateTime;
  final String category;
  final bool isCompleted;
  final bool hasReminder;
  final int reminderMinutesBefore; // За сколько минут до события отправить напоминание

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.dateTime,
    required this.category,
    this.isCompleted = false,
    this.hasReminder = true,
    this.reminderMinutesBefore = 15,
  });

  // Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'category': category,
      'isCompleted': isCompleted,
      'hasReminder': hasReminder,
      'reminderMinutesBefore': reminderMinutesBefore,
    };
  }

  // Создание из JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      category: json['category'],
      isCompleted: json['isCompleted'] ?? false,
      hasReminder: json['hasReminder'] ?? true,
      reminderMinutesBefore: json['reminderMinutesBefore'] ?? 15,
    );
  }
}
