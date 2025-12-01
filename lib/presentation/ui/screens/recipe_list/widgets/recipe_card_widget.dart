import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_nutrition.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_recipe.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class RecipeCardWidget extends StatelessWidget {
  final UIRecipe recipe;
  final VoidCallback onDeleteTap;

  const RecipeCardWidget({
    super.key,
    required this.recipe,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _RecipeCardContent(
            recipe: recipe,
            onDeleteTap: onDeleteTap,
          ),
        ),
      ),
    );
  }
}

class _RecipeCardContent extends StatelessWidget {
  final UIRecipe recipe;
  final VoidCallback onDeleteTap;

  const _RecipeCardContent({
    super.key,
    required this.recipe,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RecipeHeader(recipe: recipe, onDeleteTap: onDeleteTap),
        if (recipe.description.isNotEmpty)
          _RecipeDescription(description: recipe.description),
        const SizedBox(height: 8),
        _RecipeFruitsList(fruits: recipe.fruits),
        const SizedBox(height: 8),
        _RecipeNutritionInfo(nutrition: recipe.totalNutrition),
      ],
    );
  }
}

class _RecipeHeader extends StatelessWidget {
  final UIRecipe recipe;
  final VoidCallback onDeleteTap;

  const _RecipeHeader({
    super.key,
    required this.recipe,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            recipe.name,
            style: AppTextStyles.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: AppColors.error),
          onPressed: onDeleteTap,
        ),
      ],
    );
  }
}

class _RecipeDescription extends StatelessWidget {
  final String description;

  const _RecipeDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          description,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _RecipeFruitsList extends StatelessWidget {
  final List<UIFruit> fruits;

  const _RecipeFruitsList({
    super.key,
    required this.fruits,
  });

  @override
  Widget build(BuildContext context) {
    final fruitsText = fruits.map((f) => f.name).join(', ');

    return Text(
      '${AppStrings.ingredients}: $fruitsText',
      style: AppTextStyles.bodyMedium,
    );
  }
}

class _RecipeNutritionInfo extends StatelessWidget {
  final UINutrition nutrition;

  const _RecipeNutritionInfo({
    super.key,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _NutritionItem(
          label: AppStrings.calories,
          value: '${nutrition.calories.round()}',
        ),
        _NutritionItem(
          label: AppStrings.protein,
          value: '${nutrition.protein.toStringAsFixed(1)}${AppStrings.grams}',
        ),
        _NutritionItem(
          label: AppStrings.carbohydrates,
          value: '${nutrition.carbohydrates.toStringAsFixed(1)}${AppStrings.grams}',
        ),
        _NutritionItem(
          label: AppStrings.fat,
          value: '${nutrition.fat.toStringAsFixed(1)}${AppStrings.grams}',
        ),
      ],
    );
  }
}

class _NutritionItem extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}