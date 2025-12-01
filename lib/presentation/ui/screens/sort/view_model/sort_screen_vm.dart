import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_sort_filter_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/navigation/main_navigation.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_sort_option.dart';

import 'i_sort_screen_vm.dart';

class SortScreenVM with ChangeNotifier implements ISortScreenVM {
  final Function(SortOption?, List<FilterType>) onApply;
  final UISortFilterMapper _uiMapper;

  SortScreenVM({
    required this.onApply,
    required UISortFilterMapper uiMapper,
    required SortOption? initialSort,
    required List<FilterType> initialFilters,
  }) : _uiMapper = uiMapper {
    _selectedSort = initialSort != null
        ? _uiMapper.toUISortOptions([initialSort]).first
        : null;
    _selectedFilterTypes.addAll(initialFilters);
    notifyListeners();
  }

  SortOption? _selectedSortEntity;
  UISortOption? _selectedSort;
  final List<FilterType> _selectedFilterTypes = [];

  @override
  List<UISortOption> get sortOptions => _uiMapper.toUISortOptions(
    _createSortOptions(),
    selectedSort: _selectedSortEntity,
  );

  @override
  List<UIFilterOption> get filterOptions => _uiMapper.toUIFilterOptions(
    _createFilterOptions(),
    selectedFilters: _selectedFilterTypes,
  );

  @override
  UISortOption? get selectedSort => _selectedSort;

  @override
  List<UIFilterOption> get selectedFilters => filterOptions.where((filter) => filter.isSelected).toList();

  @override
  void selectSort(UISortOption sortOption) {
    _selectedSort = sortOption;
    _selectedSortEntity = SortOption(
      title: sortOption.title,
      type: sortOption.type,
      direction: sortOption.direction,
    );
    notifyListeners();
  }

  @override
  void toggleFilter(UIFilterOption filterOption) {
    if (_selectedFilterTypes.contains(filterOption.type)) {
      _selectedFilterTypes.remove(filterOption.type);
    } else {
      _selectedFilterTypes.add(filterOption.type);
    }
    notifyListeners();
  }

  @override
  void applySortingAndFilters(BuildContext context) {
    onApply(_selectedSortEntity, _selectedFilterTypes);
    MainNavigation.pop(context);
  }

  @override
  void resetSortingAndFilters() {
    _selectedSort = null;
    _selectedSortEntity = null;
    _selectedFilterTypes.clear();
    notifyListeners();
  }

  List<SortOption> _createSortOptions() {
    return [
      const SortOption(
        title: 'По названию (A-Z)',
        type: SortType.name,
        direction: SortDirection.ascending,
      ),
      const SortOption(
        title: 'По названию (Z-A)',
        type: SortType.name,
        direction: SortDirection.descending,
      ),
      const SortOption(
        title: 'По калориям (возрастание)',
        type: SortType.calories,
        direction: SortDirection.ascending,
      ),
      const SortOption(
        title: 'По калориям (убывание)',
        type: SortType.calories,
        direction: SortDirection.descending,
      ),
    ];
  }

  List<FilterOption> _createFilterOptions() {
    return [
      const FilterOption(
        title: 'Завтрак',
        description: '40–80 ккал, ≥10г углеводов, ≤12г сахара, ≤0.5г жиров',
        type: FilterType.breakfast,
      ),
      const FilterOption(
        title: 'Тренировка',
        description: '50–100 ккал, ≥12г углеводов, ≤0.3г жиров',
        type: FilterType.training,
      ),
      const FilterOption(
        title: 'Сытость',
        description: '50–90 ккал, 10–15г углеводов, ≤10г сахара, ≥0.5г белка',
        type: FilterType.satiety,
      ),
      const FilterOption(
        title: 'Перекус',
        description: '≤50 ккал, ≤7г сахара, ≤0.4г жиров',
        type: FilterType.snack,
      ),
      const FilterOption(
        title: 'Диета',
        description: '≤40 ккал, ≤6г сахара, ≤0.3г жиров',
        type: FilterType.diet,
      ),
    ];
  }
}