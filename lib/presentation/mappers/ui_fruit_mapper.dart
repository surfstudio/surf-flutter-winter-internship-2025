import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_nutrition.dart';

class UIFruitMapper {
  UIFruit toUIModel(Fruit entity, {bool isFavorite = false}) {
    return UIFruit(
      id: entity.id,
      name: entity.name,
      family: entity.family,
      order: entity.order,
      genus: entity.genus,
      nutritions: _toUINutrition(entity.nutritions),
      isFavorite: isFavorite,
    );
  }

  List<UIFruit> toUIList(List<Fruit> entities, {List<int> favoriteIds = const []}) {
    return entities.map((entity) {
      return toUIModel(entity, isFavorite: favoriteIds.contains(entity.id));
    }).toList();
  }

  UINutrition _toUINutrition(Nutrition nutrition) {
    return UINutrition(
      calories: nutrition.calories,
      fat: nutrition.fat,
      sugar: nutrition.sugar,
      carbohydrates: nutrition.carbohydrates,
      protein: nutrition.protein,
    );
  }
}