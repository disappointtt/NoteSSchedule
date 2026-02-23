import 'package:flutter/material.dart';

/// Виджет для отображения карточки задачи

class TaskCard extends StatelessWidget {
  final String title;
  final String? description;
  final String category;
  final String time;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TaskCard({
    Key? key,
    required this.title,
    this.description,
    required this.category,
    required this.time,
    this.isCompleted = false,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('$category • $time'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
