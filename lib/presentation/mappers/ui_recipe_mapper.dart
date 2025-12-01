import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_nutrition.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_recipe.dart';

class UIRecipeMapper {
  final UIFruitMapper _fruitMapper;

  UIRecipeMapper({required fruitMapper}): _fruitMapper = fruitMapper;

  UIRecipe toUIModel(Recipe entity) {
    return UIRecipe(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      fruits: _fruitMapper.toUIList(entity.fruits),
      createdAt: entity.createdAt,
      totalNutrition: UINutrition(
        calories: entity.totalNutrition.calories,
        fat: entity.totalNutrition.fat,
        sugar: entity.totalNutrition.sugar,
        carbohydrates: entity.totalNutrition.carbohydrates,
        protein: entity.totalNutrition.protein,
      ),
    );
  }

  List<UIRecipe> toUIList(List<Recipe> entities) {
    return entities.map(toUIModel).toList();
  }
}