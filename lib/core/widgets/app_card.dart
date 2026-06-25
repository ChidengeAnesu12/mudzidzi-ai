import 'package:flutter/material.dart';

/// Base card wrapper used across the app for consistent padding, radius,
/// and tap behavior. Theme-aware for dark mode automatically.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(borderRadius);
    final borderColor = theme.dividerTheme.color ?? theme.colorScheme.outlineVariant;

    return Material(
      color: theme.cardTheme.color ?? theme.colorScheme.surface,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: borderColor, width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}