import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';

abstract class IFruitListVM with ChangeNotifier {
  List<Fruit> get fruits;
  bool get isLoading;
  String? get error;
  bool get hasError;
  bool get hasActiveFilters;

  Future<void> getFruitList();
  void retry();
  void onCardTap(BuildContext context, Fruit fruit);
  Future<void> onFavoriteTap(Fruit fruit);
  void onSortTap(BuildContext context);
  void applySortAndFilters(SortOption? sort, List<FilterType> filters);
}