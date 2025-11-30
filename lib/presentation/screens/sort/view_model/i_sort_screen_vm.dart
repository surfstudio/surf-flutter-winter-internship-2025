import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';

abstract class ISortScreenVM with ChangeNotifier {
  List<SortOption> get sortOptions;
  List<FilterOption> get filterOptions;

  SortOption? get selectedSort;
  List<FilterOption> get selectedFilters;

  void resetSortingAndFilters();
  void selectSort(SortOption sortOption);
  void toggleFilter(FilterOption filterOption);
  void applySortingAndFilters(BuildContext context);
}

