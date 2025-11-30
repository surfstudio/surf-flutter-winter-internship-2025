import 'package:flutter/foundation.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_fruits_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

import 'i_fruit_detail_vm.dart';

class FruitDetailVM with ChangeNotifier implements IFruitDetailVM {
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final FavoritesStore _favoritesStore;
  final Fruit _fruit;

  FruitDetailVM({
    required Fruit fruit,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required FavoritesStore favoritesStore,
  })  : _fruit = fruit,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _favoritesStore = favoritesStore {
    _favoritesStore.addListener(_onFavoritesChanged);
  }

  void _onFavoritesChanged() {
    notifyListeners();
  }

  bool _isLoading = false;
  String? _error;

  @override
  Fruit get fruit => _fruit.copyWith(
    isFavorite: _favoritesStore.isFavorite(_fruit.id),
  );

  @override
  bool get isLoading => _isLoading;

  @override
  bool get hasError => _error != null;

  @override
  String? get error => _error;

  @override
  Future<void> onFavoriteTap() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _toggleFavoriteUseCase(_fruit);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to update favorite';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _favoritesStore.removeListener(_onFavoritesChanged);
    super.dispose();
  }
}