import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

/// "Need a hint?" expandable card. Tapping "Show Hint" reveals
/// step-by-step guidance text in place — matches the mockup exactly.
class HintCard extends StatelessWidget {
  const HintCard({
    super.key,
    required this.hintText,
    required this.isExpanded,
    required this.onToggle,
  });

  final String hintText;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, size: 18, color: AppColors.accent),
              const SizedBox(width: 8),
              Text('Need a hint?', style: AppTextStyles.titleLarge(color: textTheme.titleLarge?.color)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Get a step-by-step hint to guide you.',
            style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isExpanded
                ? Container(
                    key: const ValueKey('hint-text'),
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(hintText, style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color)),
                  )
                : SizedBox(
                    key: const ValueKey('hint-button'),
                    width: double.infinity,
                    child: OutlinedButton(onPressed: onToggle, child: const Text('Show Hint')),
                  ),
          ),
        ],
      ),
    );
  }
}