import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/base_remote_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_detail/fruit_detail_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/sort_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/view_model/i_sort_screen_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

import 'i_fruit_list_vm.dart';

class FruitListVM with ChangeNotifier implements IFruitListVM {
  final GetFruitsUseCase _getFruitsUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final FavoritesStore _favoritesStore;
  final ApplySortAndFilterUseCase _applySortAndFilterUseCase;

  FruitListVM({
    required GetFruitsUseCase getFruitsUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required FavoritesStore favoritesStore,
    required ApplySortAndFilterUseCase applySortAndFilterUseCase,
  }) : _getFruitsUseCase = getFruitsUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _favoritesStore = favoritesStore,
        _applySortAndFilterUseCase = applySortAndFilterUseCase {
    _favoritesStore.addListener(_onFavoritesChanged);
    _loadFruitsOnInit();
  }

  void _loadFruitsOnInit() {
    getFruitList();
  }

  void _onFavoritesChanged() {
    notifyListeners();
  }

  List<Fruit> _allFruits = [];
  List<Fruit> _displayedFruits = [];
  bool _isLoading = false;
  String? _error;
  SortOption? _currentSort;
  List<FilterType> _currentFilters = [];

  @override
  List<Fruit> get fruits => _displayedFruits
      .map(
        (fruit) => fruit.copyWith(
      isFavorite: _favoritesStore.isFavorite(fruit.id),
    ),
  )
      .toList();

  @override
  bool get isLoading => _isLoading;

  @override
  String? get error => _error;

  @override
  bool get hasError => error != null;

  @override
  bool get hasActiveFilters => _currentSort != null || _currentFilters.isNotEmpty;

  @override
  Future<void> getFruitList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allFruits = await _getFruitsUseCase();
      _applyCurrentSortAndFilters();
    } on RepositoryException catch (e) {
      _error = e.message;
      _allFruits = [];
      _displayedFruits = [];
    } catch (e) {
      _error = 'Unexpected error occurred';
      _allFruits = [];
      _displayedFruits = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _applyCurrentSortAndFilters() {
    _displayedFruits = _applySortAndFilterUseCase(
      fruits: _allFruits,
      selectedSort: _currentSort,
      selectedFilters: _currentFilters,
    );
  }

  void applySortAndFilters(SortOption? sort, List<FilterType> filters) {
    _currentSort = sort;
    _currentFilters = filters;
    _applyCurrentSortAndFilters();
    notifyListeners();
  }

  @override
  void onCardTap(BuildContext context, Fruit fruit) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FruitDetailScreenBuilder(fruit: fruit),
      ),
    );
  }

  @override
  Future<void> onFavoriteTap(Fruit fruit) async {
    try {
      await _toggleFavoriteUseCase(fruit);
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  @override
  void onSortTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SortScreenBuilder(
          onApply: (sort, filters) {
            applySortAndFilters(sort, filters);
          },
          initialSort: _currentSort,
          initialFilters: _currentFilters,
        ),
      ),
    );
  }

  @override
  void retry() {
    getFruitList();
  }

  @override
  void dispose() {
    _favoritesStore.removeListener(_onFavoritesChanged);
    super.dispose();
  }
}