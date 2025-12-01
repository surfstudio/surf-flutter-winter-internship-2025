import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';

class AppTextStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle textFieldLabel = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle textFieldHint = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
}