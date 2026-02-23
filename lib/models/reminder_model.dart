/// Модель данных для напоминания
class ReminderModel {
  final String id;
  final String taskId;
  final DateTime scheduledTime;
  final bool isSent;
  final String title;
  final String body;

  ReminderModel({
    required this.id,
    required this.taskId,
    required this.scheduledTime,
    this.isSent = false,
    required this.title,
    required this.body,
  });

  // Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'scheduledTime': scheduledTime.toIso8601String(),
      'isSent': isSent,
      'title': title,
      'body': body,
    };
  }

  // Создание из JSON
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'].toString(),
      taskId: json['taskId'].toString(),
      scheduledTime: DateTime.parse(json['scheduledTime'].toString()),
      isSent: (json['isSent'] as bool?) ?? false,
      title: json['title'].toString(),
      body: json['body'].toString(),
    );
  }
}
