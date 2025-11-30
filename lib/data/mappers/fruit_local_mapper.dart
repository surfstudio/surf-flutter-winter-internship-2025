import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';

import 'local_mapper.dart';

typedef IFruitLocalMapper = LocalMapper<Map<String, dynamic>, Fruit>;

class FruitLocalMapper implements IFruitLocalMapper {
  @override
  Fruit toEntity(Map<String, dynamic> model) {
    return Fruit(
      id: model['fruit_id'] as int,
      name: model['name'] as String,
      family: model['family'] as String,
      order: model['order_text'] as String,
      genus: model['genus'] as String,
      nutritions: Nutrition(
        calories: (model['calories'] as num).toDouble(),
        fat: (model['fat'] as num).toDouble(),
        sugar: (model['sugar'] as num).toDouble(),
        carbohydrates: (model['carbohydrates'] as num).toDouble(),
        protein: (model['protein'] as num).toDouble(),
      ),
    );
  }

  @override
  List<Fruit> toEntityList(List<Map<String, dynamic>> models) {
    return models.map(toEntity).toList();
  }

  @override
  Map<String, dynamic> toStorageModel(Fruit entity) {
    return {
      'fruit_id': entity.id,
      'name': entity.name,
      'family': entity.family,
      'order_text': entity.order,
      'genus': entity.genus,
      'calories': entity.nutritions.calories,
      'fat': entity.nutritions.fat,
      'sugar': entity.nutritions.sugar,
      'carbohydrates': entity.nutritions.carbohydrates,
      'protein': entity.nutritions.protein,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
