import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors (from Mudzidzi AI logo)
  static const Color primaryDark = Color(0xFF0F2A6B);
  static const Color primary = Color(0xFF1B3FA0);
  static const Color primaryLight = Color(0xFF2E6CDF);
  static const Color secondary = Color(0xFF1E9CFF);
  static const Color accent = Color(0xFFF5A623);
  static const Color accentDark = Color(0xFFD98C0F);

  // Semantic Colors
  static const Color success = Color(0xFF2EAD5D);
  static const Color warning = Color(0xFFF5A623);
  static const Color error = Color(0xFFE54B4B);
  static const Color info = Color(0xFF1E9CFF);

  // Light Theme Surfaces
  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1D29);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightBorder = Color(0xFFE5E9F0);

  // Dark Theme Surfaces
  static const Color darkBackground = Color(0xFF0E1320);
  static const Color darkSurface = Color(0xFF161B2C);
  static const Color darkCard = Color(0xFF1C2236);
  static const Color darkTextPrimary = Color(0xFFF2F4F8);
  static const Color darkTextSecondary = Color(0xFF9AA3B8);
  static const Color darkBorder = Color(0xFF2A3148);

  // Gradients
  static const List<Color> primaryGradient = [primary, secondary];
  static const List<Color> accentGradient = [Color(0xFFFFC56E), accent];

  // Topic Colors — match the mastery bars in the Progress screen mockup
  static const Color topicNumbers = Color(0xFF2EAD5D);
  static const Color topicAlgebra = Color(0xFF2E8BFF);
  static const Color topicFunctions = Color(0xFFF5A623);
  static const Color topicGeometry = Color(0xFFF5A623);
  static const Color topicTrigonometry = Color(0xFFE54B4B);
  static const Color topicStatistics = Color(0xFF2EAD5D);
}