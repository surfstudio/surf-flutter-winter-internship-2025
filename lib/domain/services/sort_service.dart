import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';

import 'interfaces/i_sort_service.dart';

class SortService implements ISortService {
  @override
  List<Fruit> applySorting(List<Fruit> fruits, SortOption? selectedSort) {
    if (selectedSort == null) return fruits;

    final sortedFruits = List<Fruit>.from(fruits);

    sortedFruits.sort((a, b) {
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

    return sortedFruits;
  }
}