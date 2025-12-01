import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

abstract class IFilterService {
  List<Fruit> applyFilters(
    List<Fruit> fruits,
    List<FilterType> selectedFilters,
  );
}
