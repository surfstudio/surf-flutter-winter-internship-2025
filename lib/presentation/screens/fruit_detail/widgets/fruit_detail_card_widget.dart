import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

// TODO: Extract string and colors

class FruitDetailCardWidget extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailCardWidget({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Card(
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
  final Fruit fruit;

  const _FruitInfoSection({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Основная информация'),
        const SizedBox(height: 12),
        _InfoRow(label: 'Семейство', value: fruit.family),
        _InfoRow(label: 'Порядок', value: fruit.order),
        _InfoRow(label: 'Род', value: fruit.genus),
      ],
    );
  }
}

class _FruitNutritionSection extends StatelessWidget {
  final Fruit fruit;

  const _FruitNutritionSection({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Питательные свойства'),
        const SizedBox(height: 12),
        _NutritionRow(label: 'Калории', value: fruit.nutritions.calories.toString()),
        _NutritionRow(label: 'Жиры', value: fruit.nutritions.fat.toString()),
        _NutritionRow(label: 'Сахар', value: fruit.nutritions.sugar.toString()),
        _NutritionRow(label: 'Углеводы', value: fruit.nutritions.carbohydrates.toString()),
        _NutritionRow(label: 'Белки', value: fruit.nutritions.protein.toString()),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    super.key,
    required this.label,
    required this.value,
  });

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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
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

  const _NutritionRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}