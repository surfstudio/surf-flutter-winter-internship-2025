import 'package:surf_flutter_winter_internship_2025/data/datasources/remote/dto/fruit_dto.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';

import 'network_mapper.dart';


typedef IFruitNetworkMapper = NetworkMapper<FruitDto, Fruit>;

class FruitNetworkMapper extends IFruitNetworkMapper {
  @override
  Fruit toEntity(FruitDto dto) {
    return Fruit(
      id: dto.id,
      name: dto.name,
      family: dto.family,
      order: dto.order,
      genus: dto.genus,
      nutritions: Nutrition(
        calories: dto.nutritions.calories,
        fat: dto.nutritions.fat,
        sugar: dto.nutritions.sugar,
        carbohydrates: dto.nutritions.carbohydrates,
        protein: dto.nutritions.protein,
      ),
    );
  }

  @override
  List<Fruit> toEntityList(List<FruitDto> dtos) {
    return dtos.map(toEntity).toList();
  }
}