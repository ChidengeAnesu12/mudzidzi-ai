import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'primary_button.dart';

/// Consistent loading / error / data rendering for any AsyncValue<T>.
/// Every screen backed by a FutureProvider renders through this, so
/// loading and error states look identical app-wide.
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 40, color: AppColors.error),
              const SizedBox(height: 12),
              Text(
                'Something went wrong. Please try again.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(color: AppColors.error),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                PrimaryButton(label: 'Retry', onPressed: onRetry, fullWidth: false),
              ],
            ],
          ),
        ),
      ),
    );
  }
}