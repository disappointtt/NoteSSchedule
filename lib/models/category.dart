enum TaskCategory {
  work,
  study,
  personal,
  health,
  shopping,
}

extension CategoryX on TaskCategory {
  String get label {
    switch (this) {
      case TaskCategory.work:
        return 'Работа';
      case TaskCategory.study:
        return 'Учёба';
      case TaskCategory.personal:
        return 'Личное';
      case TaskCategory.health:
        return 'Здоровье';
      case TaskCategory.shopping:
        return 'Покупки';
    }
  }

  String get emoji {
    switch (this) {
      case TaskCategory.work:
        return '💼';
      case TaskCategory.study:
        return '📚';
      case TaskCategory.personal:
        return '✨';
      case TaskCategory.health:
        return '💪';
      case TaskCategory.shopping:
        return '🛒';
    }
  }
}
