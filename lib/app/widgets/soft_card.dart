import 'package:flutter/material.dart';

class SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;

  const SoftCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.backgroundColor = Colors.white,
    this.borderRadius = 16,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          child: card,
        ),
      );
    }

    return Container(margin: margin, child: card);
  }
}
