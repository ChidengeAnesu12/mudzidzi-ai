import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Code-drawn version of the Mudzidzi AI brand mark, used on the Splash
/// screen and auth screens.
///
/// NOTE: your uploaded logo PNG only exists in this chat, not in the
/// project files, so I can't drop it into assets/ directly. If you want
/// the literal exported logo instead of this drawn version: save the PNG
/// to `assets/images/logo.png` (it's already declared under `assets:` in
/// pubspec.yaml from Phase 1), then swap the `Icon(...)` below for
/// `Image.asset('assets/images/logo.png')`. Every screen below references
/// this one widget, so the swap only needs to happen in this single file.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(Icons.school_rounded, size: size * 0.52, color: Colors.white),
    );
  }
}