import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/remote/base_remote_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/navigation/main_navigation.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_detail/fruit_detail_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/sort_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

import 'i_fruit_list_vm.dart';

class FruitListVM with ChangeNotifier implements IFruitListVM {
  final IGetFruitsUseCase _getFruitsUseCase;
  final IToggleFavoriteUseCase _toggleFavoriteUseCase;
  final IFavoritesService _favoritesService;
  final IApplySortAndFilterUseCase _applySortAndFilterUseCase;
  final UIFruitMapper _uiFruitMapper;

  StreamSubscription<Set<int>>? _favoritesSubscription;
  List<Fruit> _allFruits = [];
  List<Fruit> _displayedFruits = [];
  Set<int> _favoriteIds = {};
  bool _isLoading = false;
  String? _error;
  SortOption? _currentSort;
  List<FilterType> _currentFilters = [];

  FruitListVM({
    required IGetFruitsUseCase getFruitsUseCase,
    required IToggleFavoriteUseCase toggleFavoriteUseCase,
    required IFavoritesService favoritesService,
    required IApplySortAndFilterUseCase applySortAndFilterUseCase,
    required UIFruitMapper uiFruitMapper,
  }) : _getFruitsUseCase = getFruitsUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _favoritesService = favoritesService,
        _applySortAndFilterUseCase = applySortAndFilterUseCase,
        _uiFruitMapper = uiFruitMapper {
    _subscribeToFavorites();
    _loadFruitsOnInit();
  }

  void _loadFruitsOnInit() {
    getFruitList();
  }

  void _subscribeToFavorites() {
    _favoritesSubscription = _favoritesService.favoritesStream.listen((ids) {
      _favoriteIds = ids;
      notifyListeners();
    });
  }

  @override
  List<UIFruit> get fruits {
    return _uiFruitMapper.toUIList(
      _displayedFruits,
      favoriteIds: _favoriteIds.toList(),
    );
  }

  @override
  bool get isLoading => _isLoading;

  @override
  String? get error => _error;

  @override
  bool get hasError => error != null;

  @override
  bool get hasActiveFilters =>
      _currentSort != null || _currentFilters.isNotEmpty;

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
  void onCardTap(BuildContext context, UIFruit fruit) {
    final entityFruit = _allFruits.firstWhere(
          (element) => element.id == fruit.id,
    );
    MainNavigation.push(context, FruitDetailScreenBuilder(fruit: entityFruit));
  }

  @override
  Future<void> onFavoriteTap(UIFruit fruit) async {
    try {
      final entityFruit = _allFruits.firstWhere(
            (element) => element.id == fruit.id,
      );
      await _toggleFavoriteUseCase(entityFruit);
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  @override
  void onSortTap(BuildContext context) {
    MainNavigation.push(
      context,
      SortScreenBuilder(
        onApply: (sort, filters) {
          applySortAndFilters(sort, filters);
        },
        initialSort: _currentSort,
        initialFilters: _currentFilters,
      ),
    );
  }

  @override
  void retry() {
    getFruitList();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }
}
