import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

import '../../fruit_detail/fruit_detail_screen_builder.dart';
import 'i_favorites_vm.dart';

class FavoritesVM with ChangeNotifier implements IFavoritesVM {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final FavoritesStore _favoritesStore;

  FavoritesVM({
    required GetFavoritesUseCase getFavoritesUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required FavoritesStore favoritesStore,
  })  : _getFavoritesUseCase = getFavoritesUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _favoritesStore = favoritesStore {
    _favoritesStore.addListener(_onFavoritesChanged);
    _loadFavoritesOnInit();
  }

  void _loadFavoritesOnInit() => loadFavorites();

  void _onFavoritesChanged() {
    loadFavorites();
  }

  List<Fruit> _fruits = [];
  bool _isLoading = false;
  String? _error;

  bool get isEmpty => _fruits.isEmpty;

  @override
  List<Fruit> get fruits => _fruits;

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
      final fruits = await _getFavoritesUseCase();
      _fruits = fruits.map((fruit) => fruit.copyWith(isFavorite: true)).toList();
    } catch (e) {
      _error = 'Failed to load favorites';
      _fruits = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
  void retry() {
    loadFavorites();
  }

  @override
  void dispose() {
    _favoritesStore.removeListener(_onFavoritesChanged);
    super.dispose();
  }
}