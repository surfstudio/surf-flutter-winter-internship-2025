import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

import 'i_fruit_detail_vm.dart';

class FruitDetailVM with ChangeNotifier implements IFruitDetailVM {
  final IToggleFavoriteUseCase _toggleFavoriteUseCase;
  final IFavoritesService _favoritesService;
  final Fruit _fruitEntity;
  final UIFruitMapper _uiFruitMapper;

  StreamSubscription<Set<int>>? _favoritesSubscription;
  bool _isLoading = false;
  String? _error;

  FruitDetailVM({
    required Fruit fruit,
    required IToggleFavoriteUseCase toggleFavoriteUseCase,
    required IFavoritesService favoritesService,
    required UIFruitMapper uiFruitMapper,
  })  : _fruitEntity = fruit,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _favoritesService = favoritesService,
        _uiFruitMapper = uiFruitMapper {
    _subscribeToFavorites();
  }

  void _subscribeToFavorites() {
    _favoritesSubscription = _favoritesService.favoritesStream.listen((_) {
      notifyListeners();
    });
  }

  @override
  UIFruit get fruit => _uiFruitMapper.toUIModel(
    _fruitEntity,
    isFavorite: _favoritesService.isFavorite(_fruitEntity.id),
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

      await _toggleFavoriteUseCase(_fruitEntity);

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
    _favoritesSubscription?.cancel();
    super.dispose();
  }
}