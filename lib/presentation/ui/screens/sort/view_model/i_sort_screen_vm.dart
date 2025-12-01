import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_sort_option.dart';

abstract class ISortScreenVM with ChangeNotifier {
  List<UISortOption> get sortOptions;
  List<UIFilterOption> get filterOptions;

  UISortOption? get selectedSort;
  List<UIFilterOption> get selectedFilters;

  void resetSortingAndFilters();
  void selectSort(UISortOption sortOption);
  void toggleFilter(UIFilterOption filterOption);
  void applySortingAndFilters(BuildContext context);
}

