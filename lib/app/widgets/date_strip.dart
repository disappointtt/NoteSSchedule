import 'package:flutter/material.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';

class DateStrip extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DateStrip({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  String _getDayLabel(int weekday) {
    switch (weekday) {
      case 1:
        return 'Пн';
      case 2:
        return 'Вт';
      case 3:
        return 'Ср';
      case 4:
        return 'Чт';
      case 5:
        return 'Пт';
      case 6:
        return 'Сб';
      case 7:
        return 'Вс';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = startOfWeek.add(Duration(days: index));
          final isSelected = date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryPurple
                    : (isDark ? Colors.grey[800] : AppTheme.borderLight),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayLabel(date.weekday),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.grey[400] : AppTheme.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white : AppTheme.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
