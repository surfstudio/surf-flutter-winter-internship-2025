import 'package:json_annotation/json_annotation.dart';

part 'nutrition_dto.g.dart';

@JsonSerializable()
class NutritionDto {
  final double carbohydrates;
  final double protein;
  final double fat;
  final double calories;
  final double sugar;

  NutritionDto({
    required this.carbohydrates,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.sugar,
  });

  factory NutritionDto.fromJson(Map<String, dynamic> json) =>
      _$NutritionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionDtoToJson(this);

  @override
  String toString() {
    return 'Nutritions(calories: $calories, protein: $protein, carbs: $carbohydrates)';
  }
}