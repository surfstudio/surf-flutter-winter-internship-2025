import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class FruitDetailCardWidget extends StatelessWidget {
  final UIFruit fruit;

  const FruitDetailCardWidget({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FruitInfoSection(fruit: fruit),
            const SizedBox(height: 20),
            _FruitNutritionSection(fruit: fruit),
          ],
        ),
      ),
    );
  }
}

class _FruitInfoSection extends StatelessWidget {
  final UIFruit fruit;

  const _FruitInfoSection({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(AppStrings.basicInfo),
        const SizedBox(height: 12),
        _InfoRow(label: AppStrings.family, value: fruit.family),
        _InfoRow(label: AppStrings.order, value: fruit.order),
        _InfoRow(label: AppStrings.genus, value: fruit.genus),
      ],
    );
  }
}

class _FruitNutritionSection extends StatelessWidget {
  final UIFruit fruit;

  const _FruitNutritionSection({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(AppStrings.nutritionFacts),
        const SizedBox(height: 12),
        _NutritionRow(
          label: AppStrings.calories,
          value: fruit.nutritions.calories.toString(),
        ),
        _NutritionRow(label: AppStrings.fat, value: fruit.nutritions.fat.toString()),
        _NutritionRow(label: AppStrings.sugar, value: fruit.nutritions.sugar.toString()),
        _NutritionRow(
          label: AppStrings.carbohydrates,
          value: fruit.nutritions.carbohydrates.toString(),
        ),
        _NutritionRow(
          label: AppStrings.protein,
          value: fruit.nutritions.protein.toString(),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.titleMedium);
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionRow extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium,
          ),
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}