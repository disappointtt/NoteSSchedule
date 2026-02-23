class Reminder {
  final String id;
  final String title;
  final DateTime dateTime;
  final bool isCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.dateTime,
    this.isCompleted = false,
  });

  Reminder copyWith({
    String? id,
    String? title,
    DateTime? dateTime,
    bool? isCompleted,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
