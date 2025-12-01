import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';

abstract class ISortService {
  List<Fruit> applySorting(List<Fruit> fruits, SortOption? selectedSort);
}