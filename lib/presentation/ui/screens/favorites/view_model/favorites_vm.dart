import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/navigation/main_navigation.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

import '../../fruit_detail/fruit_detail_screen_builder.dart';
import 'i_favorites_vm.dart';

class FavoritesVM with ChangeNotifier implements IFavoritesVM {
  final IGetFavoritesUseCase _getFavoritesUseCase;
  final IToggleFavoriteUseCase _toggleFavoriteUseCase;
  final IFavoritesService _favoritesService;
  final UIFruitMapper _uiFruitMapper;

  StreamSubscription<Set<int>>? _favoritesSubscription;
  List<Fruit> _favoriteFruitsEntities = [];
  bool _isLoading = false;
  String? _error;

  FavoritesVM({
    required IGetFavoritesUseCase getFavoritesUseCase,
    required IToggleFavoriteUseCase toggleFavoriteUseCase,
    required IFavoritesService favoritesService,
    required UIFruitMapper uiFruitMapper,
  }) : _getFavoritesUseCase = getFavoritesUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _favoritesService = favoritesService,
       _uiFruitMapper = uiFruitMapper {
    _subscribeToFavorites();
    _loadFavoritesOnInit();
  }

  void _loadFavoritesOnInit() => loadFavorites();

  void _subscribeToFavorites() {
    _favoritesSubscription = _favoritesService.favoritesStream.listen((_) {
      loadFavorites();
    });
  }

  @override
  List<UIFruit> get fruits => _uiFruitMapper.toUIList(
    _favoriteFruitsEntities,
    favoriteIds: _favoriteFruitsEntities.map((f) => f.id).toList(),
  );

  @override
  bool get isEmpty => _favoriteFruitsEntities.isEmpty;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get error => _error;

  @override
  bool get hasError => error != null;

  @override
  Future<void> loadFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _favoriteFruitsEntities = await _getFavoritesUseCase();
    } catch (e) {
      _error = 'Failed to load favorites';
      _favoriteFruitsEntities = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void onCardTap(BuildContext context, UIFruit fruit) {
    final entityFruit = _favoriteFruitsEntities.firstWhere(
      (element) => element.id == fruit.id,
    );
    MainNavigation.push(context, FruitDetailScreenBuilder(fruit: entityFruit));
  }

  @override
  Future<void> onFavoriteTap(UIFruit fruit) async {
    try {
      final entityFruit = _favoriteFruitsEntities.firstWhere(
        (element) => element.id == fruit.id,
      );
      await _toggleFavoriteUseCase(entityFruit);
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  @override
  void retry() {
    loadFavorites();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }
}
