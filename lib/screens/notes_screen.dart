import 'package:flutter/material.dart';

/// Экран заметок - отображает все созданные заметки

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: const Center(
        child: Text('Здесь будет отображаться список заметок'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Открыть форму добавления новой заметки
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
