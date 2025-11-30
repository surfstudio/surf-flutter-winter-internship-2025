import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';

class RecipeCardWidget extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDeleteTap;

  const RecipeCardWidget({
    super.key,
    required this.recipe,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
  final Recipe recipe;
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
  final Recipe recipe;
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
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
          style: const TextStyle(color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _RecipeFruitsList extends StatelessWidget {
  final List<Fruit> fruits;

  const _RecipeFruitsList({
    super.key,
    required this.fruits,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: VM
    final fruitsText = fruits.map((f) => f.name).join(', ');

    return Text(
      'Состав: $fruitsText',
      style: const TextStyle(fontSize: 14),
    );
  }
}

class _RecipeNutritionInfo extends StatelessWidget {
  final Nutrition nutrition;

  const _RecipeNutritionInfo({
    super.key,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // TODO: Ex
        _NutritionItem(
          label: 'Калории',
          value: '${nutrition.calories.round()}',
        ),
        _NutritionItem(
          label: 'Белки',
          value: '${nutrition.protein.toStringAsFixed(1)}г',
        ),
        _NutritionItem(
          label: 'Углеводы',
          value: '${nutrition.carbohydrates.toStringAsFixed(1)}г',
        ),
        _NutritionItem(
          label: 'Жиры',
          value: '${nutrition.fat.toStringAsFixed(1)}г',
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}