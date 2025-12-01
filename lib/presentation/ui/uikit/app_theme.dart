import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

import 'buttons/app_buttons.dart';
import 'colors/app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.borderFocused,
        selectionColor: AppColors.selection,
        selectionHandleColor: AppColors.selectionHandle,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderEnabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderFocused),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderError),
        ),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: AppColors.textPrimary),
        hintStyle: TextStyle(color: AppColors.textSecondary),
        floatingLabelStyle: TextStyle(color: AppColors.textPrimary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(style: AppButtonStyles.elevated),
      textButtonTheme: TextButtonThemeData(style: AppButtonStyles.text),
      outlinedButtonTheme: OutlinedButtonThemeData(style: AppButtonStyles.outlined),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        extendedPadding: EdgeInsets.symmetric(horizontal: 24),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavBar,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.disabled,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surface;
        }),
      ),

      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.chip,
        labelStyle: TextStyle(color: AppColors.onSurface),
        deleteIconColor: AppColors.onSurface,
      ),

      textTheme: const TextTheme(
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.button,
      ),
    );
  }
}