import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class ErrorStateWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;
  final IconData? icon;

  const ErrorStateWidget({super.key,
    required this.onRetry,
    this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.error_outline,
            size: 64,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Произошла ошибка',
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}