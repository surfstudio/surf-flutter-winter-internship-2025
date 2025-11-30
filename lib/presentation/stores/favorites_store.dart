import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/watch_favorites_use_case.dart';

class FavoritesStore extends ChangeNotifier {
  final WatchFavoritesUseCase _watchFavoritesUseCase;
  StreamSubscription<Set<int>>? _subscription;

  Set<int> _favoriteIds = {};
  Set<int> get favoriteIds => _favoriteIds;

  FavoritesStore(this._watchFavoritesUseCase) {
    _subscribeToFavorites();
  }

  void _subscribeToFavorites() {
    _subscription = _watchFavoritesUseCase().listen((ids) {
      _favoriteIds = ids;
      notifyListeners();
    });
  }

  bool isFavorite(int fruitId) => _favoriteIds.contains(fruitId);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}