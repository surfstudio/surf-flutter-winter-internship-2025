import 'dart:async';

import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_watch_favorites_use_case.dart';

import 'interfaces/i_favorite_service.dart';

class FavoritesService implements IFavoritesService {
  final IWatchFavoritesUseCase _watchFavoritesUseCase;
  StreamSubscription<Set<int>>? _subscription;
  final StreamController<Set<int>> _favoritesController =
      StreamController<Set<int>>.broadcast();

  Stream<Set<int>> get favoritesStream => _favoritesController.stream;

  Set<int> get currentFavoriteIds => _currentFavoriteIds;

  Set<int> _currentFavoriteIds = {};

  FavoritesService(this._watchFavoritesUseCase) {
    _subscribeToFavorites();
  }

  void _subscribeToFavorites() {
    _subscription = _watchFavoritesUseCase().listen((Set<int> newFavoriteIds) {
      _currentFavoriteIds = newFavoriteIds;
      _favoritesController.add(newFavoriteIds);
    });
  }

  bool isFavorite(int fruitId) => _currentFavoriteIds.contains(fruitId);

  void dispose() {
    _subscription?.cancel();
    _favoritesController.close();
  }
}
