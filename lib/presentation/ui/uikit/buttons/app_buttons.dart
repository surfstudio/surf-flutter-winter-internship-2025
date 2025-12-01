import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class AppButtonStyles {
  static ButtonStyle elevated = ElevatedButton.styleFrom(
    foregroundColor: AppColors.onSurface,
    backgroundColor: AppColors.surface,
    minimumSize: const Size(double.infinity, 50),
    textStyle: AppTextStyles.button,
  );

  static ButtonStyle text = TextButton.styleFrom(
    foregroundColor: AppColors.onBackground,
    textStyle: AppTextStyles.bodyMedium,
  );

  static ButtonStyle outlined = OutlinedButton.styleFrom(
    foregroundColor: AppColors.onBackground,
    side: const BorderSide(color: AppColors.borderEnabled),
    minimumSize: const Size(double.infinity, 50),
    textStyle: AppTextStyles.bodyMedium,
  );
}