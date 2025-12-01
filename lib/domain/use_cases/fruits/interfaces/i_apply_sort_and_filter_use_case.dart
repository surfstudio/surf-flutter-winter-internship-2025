import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';

abstract interface class IApplySortAndFilterUseCase {
  List<Fruit> call({
    required List<Fruit> fruits,
    required SortOption? selectedSort,
    required List<FilterType> selectedFilters,
  });
}