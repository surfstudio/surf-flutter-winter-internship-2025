
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_nutrition.dart';

class UIRecipe {
  final String id;
  final String name;
  final String description;
  final List<UIFruit> fruits;
  final DateTime createdAt;
  final UINutrition totalNutrition;

  const UIRecipe({
    required this.id,
    required this.name,
    required this.description,
    required this.fruits,
    required this.createdAt,
    required this.totalNutrition,
  });

  UIRecipe copyWith({
    String? id,
    String? name,
    String? description,
    List<UIFruit>? fruits,
    DateTime? createdAt,
    UINutrition? totalNutrition,
  }) {
    return UIRecipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      fruits: fruits ?? this.fruits,
      createdAt: createdAt ?? this.createdAt,
      totalNutrition: totalNutrition ?? this.totalNutrition,
    );
  }
}