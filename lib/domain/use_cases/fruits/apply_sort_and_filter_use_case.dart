import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_filter_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_sort_service.dart';

import 'interfaces/i_apply_sort_and_filter_use_case.dart';

class ApplySortAndFilterUseCase implements IApplySortAndFilterUseCase {
  final IFilterService _filterService;
  final ISortService _sortService;

  ApplySortAndFilterUseCase({
    required IFilterService filterService,
    required ISortService sortService,
  })  : _filterService = filterService,
        _sortService = sortService;

  @override
  List<Fruit> call({
    required List<Fruit> fruits,
    required SortOption? selectedSort,
    required List<FilterType> selectedFilters,
  }) {
    List<Fruit> result = List<Fruit>.from(fruits);

    result = _filterService.applyFilters(result, selectedFilters);
    result = _sortService.applySorting(result, selectedSort);

    return result;
  }
}