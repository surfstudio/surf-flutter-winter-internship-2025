import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class AppDecorations {
  static InputDecoration textField({
    required String label,
    String? hint,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderEnabled),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderFocused),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderError),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderError),
      ),
      border: const OutlineInputBorder(),
      labelStyle: AppTextStyles.textFieldLabel,
      hintStyle: AppTextStyles.textFieldHint,
      floatingLabelStyle: AppTextStyles.textFieldLabel,
    );
  }

  static BoxDecoration card({bool isSelected = false}) {
    return BoxDecoration(
      color: isSelected ? AppColors.primary.withAlpha(30) : AppColors.card,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration container({Color? color}) {
    return BoxDecoration(
      color: color ?? AppColors.surface,
      borderRadius: BorderRadius.circular(8),
    );
  }
}