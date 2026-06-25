import 'package:flutter/material.dart';

/// Centers content and caps its width on large screens (tablet/web)
/// while taking the full width on phones. Wrap any screen's main
/// scrollable content in this for consistent responsive behavior
/// app-wide, instead of handling breakpoints per screen.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 560,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}