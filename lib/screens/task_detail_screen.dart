import 'package:flutter/material.dart';

/// Экран детального просмотра и редактирования задачи

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали задачи'),
      ),
      body: const Center(
        child: Text('Здесь будет отображаться подробная информация о задаче'),
      ),
    );
  }
}
