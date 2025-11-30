import 'package:equatable/equatable.dart';

class Nutrition extends Equatable {
  const Nutrition({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  final double calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  Nutrition copyWith({
    double? calories,
    double? fat,
    double? sugar,
    double? carbohydrates,
    double? protein,
  }) {
    return Nutrition(
      calories: calories ?? this.calories,
      fat: fat ?? this.fat,
      sugar: sugar ?? this.sugar,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      protein: protein ?? this.protein,
    );
  }

  @override
  List<Object?> get props => [
    calories,
    fat,
    sugar,
    carbohydrates,
    protein,
  ];

  @override
  String toString() {
    return 'Nutrition(calories: $calories, fat: $fat, sugar: $sugar, carbohydrates: $carbohydrates, protein: $protein)';
  }
}