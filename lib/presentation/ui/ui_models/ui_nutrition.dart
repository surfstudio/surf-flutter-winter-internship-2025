class UINutrition {
  final double calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  const UINutrition({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  UINutrition copyWith({
    double? calories,
    double? fat,
    double? sugar,
    double? carbohydrates,
    double? protein,
  }) {
    return UINutrition(
      calories: calories ?? this.calories,
      fat: fat ?? this.fat,
      sugar: sugar ?? this.sugar,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      protein: protein ?? this.protein,
    );
  }
}