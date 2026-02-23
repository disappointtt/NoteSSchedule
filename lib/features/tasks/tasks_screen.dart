import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_schedule/app/state/tasks_state.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';
import 'package:notes_schedule/app/widgets/soft_card.dart';
import 'package:notes_schedule/app/widgets/pill_stat.dart';
import 'package:notes_schedule/app/widgets/date_strip.dart';
import 'package:notes_schedule/models/category.dart';
import 'package:notes_schedule/models/task.dart';
import 'package:notes_schedule/models/reminder.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _formatDate(DateTime date) {
    final monthNames = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${date.day} ${monthNames[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final taskState = context.watch<TasksState>();
    final selectedDate = taskState.selectedDate;
    final bgColor = isDark ? Colors.grey[900]! : AppTheme.bgCard;
    final contentType = taskState.currentContentType;

    // Получаем нужный контент в зависимости от типа
    final tasks = taskState.tasksForSelectedDate;
    final meetings = taskState.meetingsForSelectedDate;
    final reminders = taskState.remindersForSelectedDate;

    List<dynamic> currentContent;
    String contentTitle;

    switch (contentType) {
      case ContentType.tasks:
        currentContent = tasks;
        contentTitle = 'Сегодняшние задачи';
        break;
      case ContentType.meetings:
        currentContent = meetings;
        contentTitle = 'Сегодняшние встречи';
        break;
      case ContentType.reminders:
        currentContent = reminders;
        contentTitle = 'Сегодняшние напоминания';
        break;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: AppTheme.primaryPurple,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NoteSSchedule',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryPurple,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      'Умный планировщик',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Greeting
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Доброе утро, Диас!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Сегодня, ${_formatDate(selectedDate)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Stats Pills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<TasksState>().setContentType(ContentType.tasks),
                    child: PillStat(
                      label: 'Задач',
                      count: taskState.tasksCount,
                      backgroundColor: AppTheme.primaryPurple,
                      isSelected: contentType == ContentType.tasks,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<TasksState>().setContentType(ContentType.meetings),
                    child: PillStat(
                      label: 'Встречи',
                      count: taskState.meetingsCount,
                      backgroundColor: AppTheme.accentGreen,
                      isSelected: contentType == ContentType.meetings,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<TasksState>().setContentType(ContentType.reminders),
                    child: PillStat(
                      label: 'Напоминания',
                      count: taskState.remindersCount,
                      backgroundColor: AppTheme.accentOrange,
                      isSelected: contentType == ContentType.reminders,
                    ),
                  ),
                ),
              ],
            ),
          ),



          // Today's Tasks Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              contentTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          const SizedBox(height: 12),

          // Tasks List
          if (currentContent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SoftCard(
                backgroundColor: bgColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      'Нет ${contentType == ContentType.tasks ? 'задач' : contentType == ContentType.meetings ? 'встреч' : 'напоминаний'} на этот день',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            )
          else if (contentType == ContentType.reminders)
            // Reminders list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentContent.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: isDark ? Colors.grey[800]! : AppTheme.borderLight,
                ),
                itemBuilder: (context, index) {
                  final reminder = currentContent[index] as Reminder;
                  return ReminderTile(
                    reminder: reminder,
                    onCompleted: () {
                      context.read<TasksState>().completeReminder(reminder.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Напоминание «${reminder.title}» выполнено'),
                          duration: const Duration(milliseconds: 1500),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          else
            // Tasks or Meetings list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentContent.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: isDark ? Colors.grey[800]! : AppTheme.borderLight,
                ),
                itemBuilder: (context, index) {
                  final task = currentContent[index] as Task;
                  return TaskTile(
                    task: task,
                    isMeeting: contentType == ContentType.meetings,
                    onCompleted: () {
                      if (contentType == ContentType.meetings) {
                        context.read<TasksState>().completeMeeting(task.id);
                      } else {
                        context.read<TasksState>().completeTask(task.id);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${contentType == ContentType.meetings ? 'Встреча' : 'Задача'} «${task.title}» выполнена',
                          ),
                          duration: const Duration(milliseconds: 1500),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onCompleted;
  final bool isMeeting;

  const TaskTile({
    Key? key,
    required this.task,
    required this.onCompleted,
    this.isMeeting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showTaskDetails(context),
        child: SoftCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          backgroundColor: Colors.transparent,
          borderRadius: 0,
          child: Row(
            children: [
              // Time
              Text(
                task.time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(width: 16),
              // Task Title
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.accentBlue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(task.category).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.category.emoji,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMeeting ? 'Детали встречи' : 'Детали задачи',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Название:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              task.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Время:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              task.time,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Категория:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${task.category.emoji} ${task.category.label}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onCompleted();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryPurple,
                ),
                child: Text(isMeeting ? 'Отметить выполненной встречу' : 'Отметить выполненной'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.work:
        return Colors.blue;
      case TaskCategory.study:
        return Colors.orange;
      case TaskCategory.personal:
        return Colors.pink;
      case TaskCategory.health:
        return Colors.green;
      case TaskCategory.shopping:
        return Colors.purple;
    }
  }
}

class ReminderTile extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onCompleted;

  const ReminderTile({
    Key? key,
    required this.reminder,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = _formatTime(reminder.dateTime);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showReminderDetails(context),
        child: SoftCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          backgroundColor: Colors.transparent,
          borderRadius: 0,
          child: Row(
            children: [
              // Time
              Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(width: 16),
              // Reminder Title
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    reminder.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Reminder Icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '🔔',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showReminderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Детали напоминания',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Название:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              reminder.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Время:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTime(reminder.dateTime),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onCompleted();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryPurple,
                ),
                child: const Text('Отметить напоминание выполненным'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
