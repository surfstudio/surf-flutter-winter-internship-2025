import 'dart:convert';

import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'local_mapper.dart';


typedef IRecipeLocalMapper = LocalMapper<Map<String, dynamic>, Recipe>;

class RecipeLocalMapper implements IRecipeLocalMapper {
  @override
  Recipe toEntity(Map<String, dynamic> model) {
    return Recipe(
      id: model['recipe_id'] as String,
      name: model['name'] as String,
      description: model['description'] as String,
      fruits: _parseFruitsFromJson(model['fruits'] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(model['created_at'] as int),
    );
  }

  @override
  List<Recipe> toEntityList(List<Map<String, dynamic>> models) {
    return models.map(toEntity).toList();
  }

  @override
  Map<String, dynamic> toStorageModel(Recipe entity) {
    return {
      'recipe_id': entity.id,
      'name': entity.name,
      'description': entity.description,
      'fruits': _convertFruitsToJson(entity.fruits),
      'created_at': entity.createdAt.millisecondsSinceEpoch,
    };
  }

  String _convertFruitsToJson(List<Fruit> fruits) {
    final fruitMaps = fruits.map((fruit) => _fruitToMap(fruit)).toList();
    return jsonEncode(fruitMaps);
  }

  Map<String, dynamic> _fruitToMap(Fruit fruit) {
    return {
      'id': fruit.id,
      'name': fruit.name,
      'family': fruit.family,
      'order': fruit.order,
      'genus': fruit.genus,
      'nutritions': {
        'calories': fruit.nutritions.calories,
        'fat': fruit.nutritions.fat,
        'sugar': fruit.nutritions.sugar,
        'carbohydrates': fruit.nutritions.carbohydrates,
        'protein': fruit.nutritions.protein,
      },
    };
  }

  List<Fruit> _parseFruitsFromJson(String? fruitsJson) {
    if (fruitsJson == null || fruitsJson.isEmpty) return [];

    try {
      final List<dynamic> fruitList = jsonDecode(fruitsJson);
      return fruitList.map((fruitMap) => _fruitFromMap(fruitMap)).toList();
    } catch (e) {
      return [];
    }
  }

  Fruit _fruitFromMap(Map<String, dynamic> fruitMap) {
    return Fruit(
      id: fruitMap['id'] as int,
      name: fruitMap['name'] as String,
      family: fruitMap['family'] as String,
      order: fruitMap['order'] as String,
      genus: fruitMap['genus'] as String,
      nutritions: Nutrition(
        calories: (fruitMap['nutritions']['calories'] as num).toDouble(),
        fat: (fruitMap['nutritions']['fat'] as num).toDouble(),
        sugar: (fruitMap['nutritions']['sugar'] as num).toDouble(),
        carbohydrates: (fruitMap['nutritions']['carbohydrates'] as num).toDouble(),
        protein: (fruitMap['nutritions']['protein'] as num).toDouble(),
      ),
    );
  }
}