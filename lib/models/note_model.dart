/// Модель данных для заметки
class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String category;
  final bool isPinned;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    required this.category,
    this.isPinned = false,
  });

  // Конвертация в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'category': category,
      'isPinned': isPinned,
    };
  }

  // Создание из JSON
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      content: json['content'].toString(),
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'].toString()) : null,
      category: json['category'].toString(),
      isPinned: (json['isPinned'] as bool?) ?? false,
    );
  }
}
