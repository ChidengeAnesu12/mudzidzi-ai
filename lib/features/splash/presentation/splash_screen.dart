import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2400));
    // No session persistence yet (frontend-only phase) — always lands on
    // Login. Once a backend exists, this will check a stored session
    // first and route straight to Dashboard if valid.
    if (mounted) context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(size: 110)
                .animate()
                .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack, duration: 700.ms)
                .fadeIn(duration: 500.ms),
            const SizedBox(height: 24),
            Text(
              'Mudzidzi AI',
              style: AppTextStyles.displayMedium(color: textTheme.displayMedium?.color),
            ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideY(begin: 0.3, end: 0),
            const SizedBox(height: 8),
            Text(
              'Learn Smarter. Achieve More.',
              style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
            ).animate().fadeIn(delay: 700.ms, duration: 500.ms),
            const SizedBox(height: 48),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2.6, color: AppColors.primary),
            ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}