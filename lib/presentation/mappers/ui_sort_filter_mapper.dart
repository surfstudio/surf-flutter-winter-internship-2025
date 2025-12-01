import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_sort_option.dart';

class UISortFilterMapper {
  List<UISortOption> toUISortOptions(List<SortOption> entities, {SortOption? selectedSort}) {
    return entities.map((entity) {
      return UISortOption(
        title: _getSortTitle(entity),
        type: entity.type,
        direction: entity.direction,
        isSelected: entity == selectedSort,
      );
    }).toList();
  }

  List<UIFilterOption> toUIFilterOptions(List<FilterOption> entities, {List<FilterType> selectedFilters = const []}) {
    return entities.map((entity) {
      return UIFilterOption(
        title: _getFilterTitle(entity.type),
        description: _getFilterDescription(entity.type),
        type: entity.type,
        isSelected: selectedFilters.contains(entity.type),
      );
    }).toList();
  }

  String _getSortTitle(SortOption sort) {
    switch (sort.type) {
      case SortType.name:
        return sort.direction == SortDirection.ascending ? 'По названию (A-Z)' : 'По названию (Z-A)';
      case SortType.calories:
        return sort.direction == SortDirection.ascending ? 'По калориям (возрастание)' : 'По калориям (убывание)';
    }
  }

  String _getFilterTitle(FilterType type) {
    switch (type) {
      case FilterType.breakfast: return 'Завтрак';
      case FilterType.training: return 'Тренировка';
      case FilterType.satiety: return 'Сытость';
      case FilterType.snack: return 'Перекус';
      case FilterType.diet: return 'Диета';
    }
  }

  String _getFilterDescription(FilterType type) {
    switch (type) {
      case FilterType.breakfast: return '40–80 ккал, ≥10г углеводов, ≤12г сахара, ≤0.5г жиров';
      case FilterType.training: return '50–100 ккал, ≥12г углеводов, ≤0.3г жиров';
      case FilterType.satiety: return '50–90 ккал, 10–15г углеводов, ≤10г сахара, ≥0.5г белка';
      case FilterType.snack: return '≤50 ккал, ≤7г сахара, ≤0.4г жиров';
      case FilterType.diet: return '≤40 ккал, ≤6г сахара, ≤0.3г жиров';
    }
  }
}