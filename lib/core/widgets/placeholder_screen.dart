import 'package:flutter/material.dart';

/// Temporary placeholder used until each real screen is built.
/// Every feature screen built in later phases will replace its
/// corresponding route target — this file itself is never deleted,
/// only its usages are swapped out one by one.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}