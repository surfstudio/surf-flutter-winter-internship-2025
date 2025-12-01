import 'package:equatable/equatable.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';

import 'fruit.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<Fruit> fruits;
  final DateTime createdAt;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.fruits,
    required this.createdAt,
  });

  Nutrition get totalNutrition {
    double calories = 0;
    double fat = 0;
    double sugar = 0;
    double carbohydrates = 0;
    double protein = 0;

    for (final fruit in fruits) {
      calories += fruit.nutritions.calories;
      fat += fruit.nutritions.fat;
      sugar += fruit.nutritions.sugar;
      carbohydrates += fruit.nutritions.carbohydrates;
      protein += fruit.nutritions.protein;
    }

    return Nutrition(
      calories: calories,
      fat: fat,
      sugar: sugar,
      carbohydrates: carbohydrates,
      protein: protein,
    );
  }

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    List<Fruit>? fruits,
    DateTime? createdAt,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      fruits: fruits ?? this.fruits,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    fruits,
    createdAt,
  ];

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, fruits: ${fruits.length}, createdAt: $createdAt)';
  }
}