import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

import 'interfaces/i_filter_service.dart';

class FilterService implements IFilterService {
  @override
  List<Fruit> applyFilters(
    List<Fruit> fruits,
    List<FilterType> selectedFilters,
  ) {
    if (selectedFilters.isEmpty) return fruits;

    return fruits.where((fruit) {
      final nutritions = fruit.nutritions;

      for (final filter in selectedFilters) {
        switch (filter) {
          case FilterType.breakfast:
            if (!(nutritions.calories >= 40 &&
                nutritions.calories <= 80 &&
                nutritions.carbohydrates >= 10 &&
                nutritions.sugar <= 12 &&
                nutritions.fat <= 0.5)) {
              return false;
            }
            break;
          case FilterType.training:
            if (!(nutritions.calories >= 50 &&
                nutritions.calories <= 100 &&
                nutritions.carbohydrates >= 12 &&
                nutritions.fat <= 0.3)) {
              return false;
            }
            break;
          case FilterType.satiety:
            if (!(nutritions.calories >= 50 &&
                nutritions.calories <= 90 &&
                nutritions.carbohydrates >= 10 &&
                nutritions.carbohydrates <= 15 &&
                nutritions.sugar <= 10 &&
                nutritions.protein >= 0.5)) {
              return false;
            }
            break;
          case FilterType.snack:
            if (!(nutritions.calories <= 50 &&
                nutritions.sugar <= 7 &&
                nutritions.fat <= 0.4)) {
              return false;
            }
            break;
          case FilterType.diet:
            if (!(nutritions.calories <= 40 &&
                nutritions.sugar <= 6 &&
                nutritions.fat <= 0.3)) {
              return false;
            }
            break;
        }
      }
      return true;
    }).toList();
  }
}
