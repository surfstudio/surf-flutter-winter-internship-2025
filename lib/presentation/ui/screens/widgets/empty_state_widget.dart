import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final String message;
  final IconData icon;

  const EmptyStateWidget({super.key,
    required this.onRefresh,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textPrimary),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRefresh,
            child: const Text('Обновить'),
          ),
        ],
      ),
    );
  }
}