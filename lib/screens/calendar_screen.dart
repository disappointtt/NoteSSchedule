import 'package:flutter/material.dart';

/// Экран календаря - отображает все задачи календарем

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
      ),
      body: const Center(
        child: Text('Здесь будет отображаться календарь с задачами'),
      ),
    );
  }
}
