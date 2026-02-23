import 'package:flutter/material.dart';
import 'package:notes_schedule/app/theme/app_theme.dart';

class PillStat extends StatelessWidget {
  final String label;
  final int count;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final bool isSelected;

  const PillStat({
    Key? key,
    required this.label,
    required this.count,
    required this.backgroundColor,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
            ? backgroundColor.withOpacity(0.2)
            : backgroundColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
              ? backgroundColor 
              : backgroundColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: backgroundColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
