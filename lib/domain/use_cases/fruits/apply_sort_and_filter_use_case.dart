import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/view_model/i_sort_screen_vm.dart';

class ApplySortAndFilterUseCase {
  List<Fruit> call({
    required List<Fruit> fruits,
    required SortOption? selectedSort,
    required List<FilterType> selectedFilters,
  }) {
    List<Fruit> result = List<Fruit>.from(fruits);

    result = _applyFilters(result, selectedFilters);

    result = _applySorting(result, selectedSort);

    return result;
  }

  List<Fruit> _applyFilters(List<Fruit> fruits, List<FilterType> selectedFilters) {
    if (selectedFilters.isEmpty) return fruits;

    return fruits.where((fruit) {
      final nutritions = fruit.nutritions;

      for (final filter in selectedFilters) {
        switch (filter) {
          case FilterType.breakfast:
            if (!(nutritions.calories >= 40 && nutritions.calories <= 80 &&
                nutritions.carbohydrates >= 10 &&
                nutritions.sugar <= 12 &&
                nutritions.fat <= 0.5)) {
              return false;
            }
            break;
          case FilterType.training:
            if (!(nutritions.calories >= 50 && nutritions.calories <= 100 &&
                nutritions.carbohydrates >= 12 &&
                nutritions.fat <= 0.3)) {
              return false;
            }
            break;
          case FilterType.satiety:
            if (!(nutritions.calories >= 50 && nutritions.calories <= 90 &&
                nutritions.carbohydrates >= 10 && nutritions.carbohydrates <= 15 &&
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

  List<Fruit> _applySorting(List<Fruit> fruits, SortOption? selectedSort) {
    if (selectedSort == null) return fruits;

    fruits.sort((a, b) {
      int comparison = 0;

      switch (selectedSort.type) {
        case SortType.name:
          comparison = a.name.compareTo(b.name);
          break;
        case SortType.calories:
          comparison = a.nutritions.calories.compareTo(b.nutritions.calories);
          break;
      }

      return selectedSort.direction == SortDirection.descending ? -comparison : comparison;
    });

    return fruits;
  }
}