import 'package:flutter/material.dart';

/// Главный экран приложения - отображает предстоящие задачи на сегодня

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: const Center(
        child: Text('Экран будет содержать список предстоящих задач'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Открыть форму добавления новой задачи
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
